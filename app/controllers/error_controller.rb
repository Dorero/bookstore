# frozen_string_literal: true

class ErrorController < ApplicationController
  def not_found
    render status: :not_found
  end
end
