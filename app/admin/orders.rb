# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params :status, :delivery_id, :number, :id

  menu priority: 4

  actions :index, :show

  scope(I18n.t(:in_progress_tab), default: true) do |orders|
    orders.where(status: %i[in_delivery checking_address checking_delivery checking_payment checking_confirm
                            checking_complete complete])
  end
  scope(I18n.t(:delivered_tab)) { |orders| orders.where(status: :delivered) }
  scope(I18n.t(:canceled_tab)) { |orders| orders.where(status: :canceled) }

  filter :status
  filter :number
  filter :created_at
  filter :updated_at
  filter :delivery, as: :select, collection: proc {
    Delivery.all.map do |delivery|
      [delivery.method, delivery.id]
    end
  }

  index do
    selectable_column
    column :id
    column :number
    column :status
    actions
  end

  show title: proc { |order| order.decorate.title } do
    attributes_table :id, :status, :number, :created_at, :updated_at do
      row :books do
        order.books.map { |book| link_to book.name, admin_book_path(book.id) }
      end
    end
  end

  batch_action :delivered, if: proc { @current_scope.name == I18n.t(:in_progress_tab) } do |ids|
    is_success = false
    Order.where(id: ids).find_each do |order|
      is_success = order.to_delivered! if order.in_delivery?
      break unless is_success
    end

    if is_success
      redirect_to collection_path, notice: I18n.t(:order_status_success_changed)
    else
      redirect_to collection_path, alert: I18n.t(:cannot_set_delivered)
    end
  end

  batch_action :in_delivery, if: proc { @current_scope.name != I18n.t(:canceled_tab) } do |ids|
    Order.where(id: ids).find_each(&:to_in_delivery!)

    redirect_to collection_path, notice: I18n.t(:order_status_success_changed)
  end

  batch_action :canceled do |ids|
    Order.where(id: ids).find_each(&:to_canceled)

    redirect_to collection_path, notice: I18n.t(:order_status_success_changed)
  end
end
