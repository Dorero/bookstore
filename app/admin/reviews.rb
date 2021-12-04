# frozen_string_literal: true

ActiveAdmin.register Review do
  permit_params :title, :message, :stars, :status, :user_id, :book_id

  includes(:user, :book)

  menu priority: 5

  actions :index, :show

  scope :all
  scope(I18n.t(:new)) { |review| review.where(status: I18n.t(:unprocessed_status)) }
  scope(I18n.t(:processed)) { |review| review.where(status: [I18n.t(:approved_status), I18n.t(:rejected_status)]) }

  filter :title
  filter :created_at
  filter :updated_at
  filter :stars
  filter :user, as: :select, collection: proc {
    User.all.map do |user|
      [user.decorate.name, user.id]
    end
  }

  index do
    selectable_column
    column :id
    column :title
    column :message
    column :status
    column :created_at
    column :updated_at
    column :book
    column :user do |review|
      review.user.decorate.show_email_or_name
    end

    actions
  end

  action_item :approve, only: :show do
    link_to I18n.t(:approve_button), approve_admin_review_path, 'data-confirm': I18n.t(:approve_review_confirm),
                                                                method: :patch
  end

  action_item :reject, only: :show do
    link_to I18n.t(:reject_button), reject_admin_review_path, 'data-confirm': I18n.t(:reject_review_confirm),
                                                              method: :patch
  end

  member_action :approve, method: :patch do
    resource.approved!
    redirect_to admin_reviews_path, alert: I18n.t(:review_approved_flash)
  end

  member_action :reject, method: :patch do
    resource.rejected!
    redirect_to admin_reviews_path, alert: I18n.t(:review_rejected_flash)
  end
end
