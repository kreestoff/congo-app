class User < ApplicationRecord
    has_many :purchases
    has_many :items, through: :purchases

    def categories
      c = []
      self.items.each do |item|
        c << item.category
      end
      c.uniq
    end

    def suggested_items
      Item.all.find_all do |i|
        next if self.items.include?(i)
        self.categories.include?(i.category)
      end
    end

end
