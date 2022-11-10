# frozen_string_literal: true

class Marketplace
  class Cart < ApplicationRecord
    self.table_name = 'marketplace_carts'

    belongs_to :marketplace
    delegate :space, :room, to: :marketplace
    has_many :cart_products
    has_many :products, through: :cart_products

    def self.model_name
      @_model_name ||= ActiveModel::Name.new(self, ::Marketplace)
    end
  end
end
