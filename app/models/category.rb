class Category < ApplicationRecord
  has_many :products, dependent: :restrict_with_error
  has_many :sub_categories, dependent: :destroy, class_name: 'Category', foreign_key: 'parent_category_id'
  belongs_to :parent_category, class_name: 'Category', required: false
  has_many :sub_category_products, through: :sub_categories, source: :products

  validates :name, presence: true

  # FIXME:: IF PARENT_ID = NIL, THEN, ADD METHOD
  # validates :name, uniqueness: { case_sensitive: false }, allow_blank: true

  validates :name, uniqueness: { scope: :parent_category, case_sensitive: false }, allow_blank: true
  # combination of category and sub_category unique!
  # works for root category, as parent_category becomes nil

  validate :ensure_parent_not_a_sub_category

  before_destroy :ensure_no_sub_category_products

  private
    def ensure_parent_not_a_sub_category
      # if (not root category) && ( two level nesting )
      if parent_category_id && Category.find(parent_category_id).parent_category_id.present?
        raise "Sub-categories can't have sub-categories"
      end
    end

    def ensure_no_sub_category_products
      if sub_category_products.present?
        false
      end
    end
end
