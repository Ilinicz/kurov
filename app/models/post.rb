class Post < ActiveRecord::Base
  require 'babosa'
  include R18n::Translated


  # Use friendly_id
  extend FriendlyId
  friendly_id :title, use: :slugged
  
  # Markdown
  before_save { Markdown.update_html(self) }
    
  # Validations
  validates :title, presence: true, length: { maximum: 100 }, uniqueness: true
  validates :content_md, presence: true
  
  # Pagination
  paginates_per 30  
  
  # Relations
  belongs_to :user
  
  # Scopes  
  scope :published, lambda {
    where(draft: false)
    .order("updated_at DESC")
  }
  
  scope :drafted, lambda {
    where(draft: true)
    .order("updated_at DESC")
  }

  def normalize_friendly_id(input)
    input.to_s.to_slug.normalize(transliterations: :russian).to_s
  end
end