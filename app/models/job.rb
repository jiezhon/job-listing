class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0}

  has_many :resumes, :dependent => :destroy
  has_many :candidates, through: :resumes, source: :user

  has_many :favor_job_relationships
  has_many :followers, through: :favor_job_relationships, source: :user

  has_many :locations, :dependent => :destroy, :inverse_of => :job
  accepts_nested_attributes_for :locations, :allow_destroy => true, :reject_if => :all_blank

  include RankedModel
  ranks :row_order

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end

  scope :published, -> { where(is_hidden: false) }
  scope :recent, -> { order('created_at DESC') }

end
