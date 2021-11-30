# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pagy::Backend

  private

  def prepare_errors(errors)
    errors.each_with_object({}) { |error, memo| memo[error.attribute.to_s] = error.message }
  end
end
