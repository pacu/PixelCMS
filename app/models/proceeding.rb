class Proceeding < ActiveRecord::Base
  include ActiveAdmin::Callbacks
  include ActiveRecord::Callbacks

  attr_accessible :deposit_date,
                  :end_date,
                  :exchange_rate,
                  :start_date,
                  :total_usd,
                  :publisher_id,
                  :share_percent,
                  :payment_date,
                  :name

  before_save :update_share
  belongs_to :publisher


  validates :deposit_date, :start_date, :end_date, timeliness: {on_or_before: lambda { Date.current}, type: :date}, :presence => true
  validates :exchange_rate, :presence => true, :numericality =>  {:greater_than_or_equal_to => 0}
  validates :start_date, timeliness: {on_or_before: lambda {self.end_date }, type: :date}


  def update_share
     total_share =   Sale.where( start_date: start_date..end_date, publisher_id: publisher).sum('sales.share_usd')

     self.share_percent= publisher.share_percent
     self.total_usd= ((total_share*self.share_percent)/100).round(2)

  end


  def share_ars
    (total_usd*exchange_rate).round(2)
  end



end
