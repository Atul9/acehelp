# frozen_string_literal: true

class Url < ApplicationRecord
  default_scope -> { order("created_at ASC") }
  has_many :article_urls
  has_many :articles, through: :article_urls
  belongs_to :organization

  validates_uniqueness_of :url, case_sensitive: false
  validates_with HttpUrlValidator

  scope :for_organization, ->(org) { where(organization: org) }
end
