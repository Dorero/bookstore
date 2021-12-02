# frozen_string_literal: true

ActiveAdmin.register Review do
  permit_params :title, :message, :stars, :status, :user_id, :book_id

  menu priority: 5

  actions :index

  scope :all
  scope('New') { |review| review.where(status: 'Unprocessed') }
  scope('Processed') { |review| review.where(status: %w[Approved Rejected]) }

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
      review.user.decorate.name
    end

    column do |review|
      span link_to I18n.t(:show_button), view_admin_review_path(review)
    end
  end

  member_action :view, method: :get do
  end

  member_action :approved, method: :patch do
    resource.status = 'Approved'
    resource.save
    redirect_to admin_reviews_path, alert: I18n.t(:review_approved)
  end

  member_action :rejected, method: :patch do
    resource.status = 'Rejected'
    resource.save
    redirect_to admin_reviews_path, alert: I18n.t(:review_rejected)
  end

  includes(:user, :book)
end
