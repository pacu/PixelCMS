require 'spec_helper'


describe ProductsController do
	describe 'routing' do
		
		it 'should route to provide_content' do
			
			@invalid_receipt = "#{open("/home/bitnami/stack/projects/pixelProvider/spec/controllers/receipt").read}"
			purchase_path( {:publication => 'kidsbible_oldtestament', :product_id =>'kidsbible.oldtestament.chapter3', :receipt => @invalid_receipt})
					
 		end
	
	end
	describe 'purchase a product' do
		it 'should call the method that provides the purchase' do
			receipt = {"product_id" => "kidsbible.oldtestament.chapter3"}
	
			app_store_response = {:status => 0, :receipt => receipt}
			ReceiptValidator.any_instance.stub(:verify).and_return(app_store_response)
			validator = ReceiptValidator.new()
			purchase_path( {:publication => 'kidsbible_oldtestament', :product_id => receipt['product_id'], :receipt => 'asdfasd'})
			
			ReceiptValidator.any_instance.unstub(:verify)
		end
		
		it 'should return 404 if receipt is not valid' do
					
			receipt = {"product_id" => "kidsbible.oldtestament.chapter3"}
			app_store_response = {:status => -1, :receipt => receipt}
			ReceiptValidator.any_instance.stub(:verify).and_return(app_store_response)
			validator = ReceiptValidator.new()
			#@validator.stub(:verify).and_return(app_store_response)
			
			validator.verify('sdfasd',"fasdfaa").should be_equal(app_store_response)
		
			purchase_path ({:publication =>'kidsbible_oldtestament',:product_id => 'kidsbible.oldtestament.chapter3', :receipt => 'fasdfagafgs'}).should redirect_to :status => 404		
			ReceiptValidator.any_instance.unstub(:verify)
		end
		it 'should return 404 if receipt is valid but the product ids do  not match' do
			
			@validator = ReceiptValidator.new()
			receipt = {"product_id" => "not.a.valid.product"}
			app_store_response = {:status => 0, :receipt => receipt}
			@validator.stub(:verify).and_return(app_store_response)

			
			purchase_path( {:publication => 'kidsbible_oldtestament', :product_id => 'kidsbible.oldtestament.chapter3', :receipt => receipt}).should redirect_to :status => 404
				
			@validator.unstub(:verify)
		end
	end
end	
