# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params :status, :delivery_id, :number, :id

  menu priority: 4

  actions :index, :show

  scope(:all) { |order| order.where.not(status: :cart) }
  scope(I18n.t(:in_progress_tab)) { |order| order.where(status: %i[in_progress in_queue]) }
  scope(I18n.t(:delivered_tab)) { |order| order.where(status: :delivered) }
  scope(I18n.t(:canceled_tab)) { |order| order.where(status: :canceled) }

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

  batch_action :change_state, form: { type: %w[in_delivery delivered canceled] } do |ids, status|
    statuses = { 'in_delivery' => :start_delivery!, 'delivered' => :deliver!, 'canceled' => :cancel! }
    if statuses.keys.include?(status[:type])
      is_success = true
      Order.find(ids).each do |order|
        is_success = order.public_send(statuses[status[:type]].to_sym)
        break unless is_success
      end

      if is_success
        redirect_to collection_path, alert: I18n.t(:order_status_success_changed)
      else
        redirect_to collection_path, alert: I18n.t(:cannot_set_delivered)
      end
    else
      redirect_to collection_path, alert: I18n.t(:cannot_set_status)
    end
  end
end
