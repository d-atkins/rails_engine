module Searchable
  def self.included(klass)
    klass.extend ClassMethods
  end

  module ClassMethods
    def search(query_params)
      query_params.reduce(all) do |matches, (attribute, value)|
        if partial_matchables.include?(attribute)
          matches.partial_search(attribute, value)
        else
          matches.where(attribute.to_sym => value)
        end
      end
    end

    def partial_search(attribute, value)
      where("#{attribute} ILIKE '%#{value}%'")
    end
  end
end
