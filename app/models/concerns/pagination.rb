module Pagination
  extend ActiveSupport::Concern

  included do
    def self.paginate(page)
      limit(per_page).offset(normalize_offset(page))
    end

    def self.per_page
      50
    end

    def self.normalize_offset(page = 1)
      page = page.to_i - 1
      page = page < 0 ? 0 : page
      page * per_page
    end
  end
end
