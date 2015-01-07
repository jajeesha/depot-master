class Product < ActiveRecord::Base
  #default_scope order: 'title'
  validates :title, :description, :presence =>true
  validates :price, :numericality =>{:greater_then_or_equal_to => 0.01}
  validates :title, :uniqueness => true
  validates :title, length: {minimum: 10}
  #validates :image_url, :format => {
  #    :with   => %r{\.(gif|jpg|png)$}i,
  #    :message => 'must be a URL for GIF, JPG or PNG image.'
  #}
  has_many :line_items
  has_many :orders, :through => :line_items
  before_destroy :ensure_not_referenced_by_any_line_items




  private
  def ensure_not_referenced_by_any_line_items
    if line_items.empty?
      return true
    else
      errors.add(:base,'line item present')
      return false
    end
  end
end