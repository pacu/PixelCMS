class Sale < ActiveRecord::Base

  require 'smarter_csv'
  attr_accessible :isrc_isbn,
                  :apple_identifier,
                  :country,
                  :customer_currency,
                  :customer_price,
                  :end_date,
                  :extended_partner_share,
                  :grid,
                  :isan,
                  :label_studio,
                  :partner_share,
                  :extended_partner_share,
                  :partner_share_currency,
                  :product_type,
                  :quantity,
                  :sales_return,
                  :seller_type,
                  :usd_exchange_rate,
                  :start_date,
                  :upc,
                  :product_identifier,
                  :preorder_flag,
                  :share_usd,
                  :promo_code






  belongs_to :publisher

  validates_presence_of  :start_date, :end_date, :usd_exchange_rate, :extended_partner_share, :share_usd, :product_identifier


  def self.mapping
    return {


        :sales_or_return => :sales_return,
        :artist_show_developer_author => :seller_type,
        :label_studio_network_developer_publisher => :label_studio,
        :vendor_identifier => :product_identifier,
        :product_type_identifier => :product_type,
        :isan_other_identifier => :isan,
        :country_of_sale => :country,
        :pre_order_flag => :preorder_flag,


    }
  end



  def self.import_csv(file,exchange_rate)

    issue_hash = Hash.new
    sales = Array.new
    total_chunks = SmarterCSV.process(file.tempfile,{:col_sep => "\t",:convert_values_to_numeric => true, :chunk_size => 20, :key_mapping => Sale.mapping}) do |chunk|

      chunk.each do |h|
        h.delete :title



        break if should_end_parsing?(h)


        current_sale = Sale.new(h)

        current_sale.usd_exchange_rate= exchange_rate
        current_issue = issue_hash[current_sale.product_identifier]
        if !current_issue
          current_issue = Issue.find_by_product_id current_sale.product_identifier
          raise "Unrecognized product ID #{current_sale.product_identifier}!" if !current_issue
          issue_hash[current_issue.product_id]=current_issue if current_issue
        end
        current_sale.publisher =current_issue.publication.publisher
        if current_sale.extended_partner_share
          converted_share = (current_sale.extended_partner_share * current_sale.usd_exchange_rate)
          current_sale.share_usd = converted_share.round(2)
        end
        end_date = DateTime.strptime h[:end_date],'%m/%d/%Y'
        start_date = DateTime.strptime h[:start_date],'%m/%d/%Y'
        current_sale.start_date= start_date.to_date
        current_sale.end_date=  end_date.to_date


        sales << current_sale

      end


    end

    Sale.transaction do
      sales.each { |s| s.save! }

    end
  end
  def self.should_end_parsing?(h)

    h.length <= 2


  end



end
