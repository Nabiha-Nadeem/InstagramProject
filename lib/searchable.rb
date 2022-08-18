# frozen_string_literal: true

# module to search
module Searchable
  # module to make the method as class method
  module ClassMethods
    def search_like_any(attributes, keyword)
      return if attributes.blank? || keyword.blank?

      values = keyword.split(/[,?.\s]/).uniq.reject(&:blank?)
      matches = attributes.uniq.product(values).map do |(attr, value)|
        arel_table[attr].matches("%#{value}%")
      end
      where matches.inject(:or)
    end
  end

  def self.included(receiver)
    receiver.extend ClassMethods
  end
end
