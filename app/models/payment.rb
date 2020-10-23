class Payment < ApplicationRecord
  attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year, :card_name
  belongs_to :user

  def self.month_options
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1] }
  end

  def self.year_options
    (Date.today.year..(Date.today.year + 10)).to_a
  end

  def process_payment
    customer = Stripe::Customer.create email: email, name: card_name, source: 'tok_visa'
    Stripe::Charge.create customer: customer.id, amount: 1000, description: 'premium', currency: 'usd'
  end
  
end
