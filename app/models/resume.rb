class Resume < ApplicationRecord

  STATUS = ["pending", "confirmed"]
  validates_inclusion_of :status, :in => STATUS
  validates_presence_of :status, :location_id

  validates :content, presence: true
  validates_presence_of :name, :email, :cellphone

  belongs_to :job
  belongs_to :location
  belongs_to :user, :optional => true

  mount_uploader :attachment, AttachmentUploader

  before_validation :generate_uuid, :on => :create

  scope :by_status, ->(s){ where( :status => s ) }
  scope :by_location, ->(l){ where( :location_id => l ) }

  def to_param
    self.uuid
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
