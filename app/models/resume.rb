class Resume < ApplicationRecord

  validates :content, presence: true
  validates_presence_of :name, :email, :cellphone

  belongs_to :job
  belongs_to :user, :optional => true

  mount_uploader :attachment, AttachmentUploader

  before_validation :generate_uuid, :on => :create

  def to_param
    self.uuid
  end

  def generate_uuid
    self.uuid = SecureRandom.uuid
  end
end
