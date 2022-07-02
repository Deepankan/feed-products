class User < ApplicationRecord
  ADMIN = 'admin'
  PROVIDER = 'provider'

  enum role: [ADMIN, PROVIDER]

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :providers

  after_create :create_provider, unless: Proc.new { |user| user.role == ADMIN }

  def create_provider
    self.providers.create(name: self.name).save
  end
end
