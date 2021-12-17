# frozen_string_literal: true

ActiveAdmin.register Order do
  permit_params :status, :delivery_id, :number, :id

  menu priority: 4

  actions :index, :edit, :update

  scope(:all)
  scope(I18n.t(:in_progress_tab)) { |order| order.where(status: %i[in_progress in_queue in_delivery]) }
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
    column do |order|
      link_to I18n.t(:change_state), edit_admin_order_path(order)
    end
  end

  form do |f|
    f.inputs do
      f.input :status, as: :select, include_blank: false, collection: %i[delivered canceled in_delivery]
    end
    actions
  end

  controller do
    def update
      status = params[:order][:status]
      return path_when_exception(I18n.t(:cannot_set_status)) unless %w[delivered canceled in_delivery].include?(status)

      order = Order.find(params[:id])
      return path_when_exception(I18n.t(:cannot_set_delivered)) if !order.in_delivery? && status == 'delivered'

      change_state(order, status)
    end

    private

    def path_when_exception(message)
      redirect_to edit_admin_order_path(params[:id]), alert: message
    end

    def change_state(order, status)
      order.update(status: status, completed: Time.now)
      redirect_to admin_orders_path, notice: I18n.t(:order_status_success_changed)
    end
  end
end
