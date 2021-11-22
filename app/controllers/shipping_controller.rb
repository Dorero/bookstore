class ShippingController < ApplicationController
  before_action :permit_params

  def update
    data = { first_name: params[:fname], last_name: params[:lname], address: params[:address], city: params[:city],
             zip: params[:zip], country: params[:country], phone: params[:phone]}
    errors = []

    if Billing.exists?(user_id: params[:id])
      billing_address = Billing.all.find_by(user_id: params[:id])
      billing_address.first_name = data[:first_name]
      billing_address.last_name = data[:last_name]
      billing_address.address = data[:address]
      billing_address.city = data[:city]
      billing_address.zip = data[:zip]
      billing_address.country = data[:country]
      billing_address.phone = data[:phone]
      errors = billing_address.save.errors
    else
      errors = Billing.create(data).errors
    end

    redirect_to(controller: :user, action: :edit, first_name: errors[:first_name].join(', '),
                last_name: errors[:first_name].join(', '), address: errors[:address].join(', '),
                city: errors[:city].join(', '), zip: errors[:zip].join(', '), country: errors[:country].join(', '),
                phone: errors[:phone].join(', '))

  end

  private

  def permit_params
    params.permit(:id, :fname, :lname, :address, :city, :zip, :country, :phone)
  end
end
