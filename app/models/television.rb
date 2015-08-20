class Television < ActiveRecord::Base

  filterrific :default_filter_params => { :sorted_by => 'regularprice_desc' },
              :available_filters => %w[
                sorted_by
                search_query
                with_brand
                with_regularprice
              ]

  # default for will_paginate
  self.per_page = 10

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 2
    where(
      terms.map {
        or_clauses = [
          "LOWER(televisions.name) LIKE ?",
          "LOWER(televisions.brand) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^regularprice_/
      order("televisions.regularprice #{ direction }")
    when /^brand_/
      order("LOWER(televisions.brand) #{ direction }")
    when /^name_/
      order("LOWER(televisions.name) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  scope :with_brand, lambda { |brands|
    where(:brand => [*brands])
  }
  scope :with_regularprice, lambda { |ref_price|
    where('televisions.regularprice >= ?', ref_price)
  }

  delegate :name, :to => :brand, :prefix => true

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Price (High to Low)', 'regularprice_desc'],
      ['Price (Low to High)', 'regularprice_asc'],
      ['Brand (a-z)', 'brand_asc']
    ]
  end

  def decorated_created_at
    created_at.to_date.to_s(:long)
  end

  def self.options_for_select
    order('LOWER(brand)').map{ |e| [e.brand] }.uniq

  end
end
