class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable, :validatable, :registerable, :recoverable, :confirmable,
         :lockable, :timeoutable, :trackable

  before_create :init_role

  has_many :notes

  extend FriendlyId
  friendly_id :login, use: %i[slugged]

  ROLES = %w[guest user admin].freeze

  validates :login,
      presence: true,
      uniqueness: true,
      exclusion: { in: LOGIN_BLACKLIST },
      length: { in: 3..12 },
      format: { with: /\A[A-Za-z0-9_]+\z/ }

  def roles=(roles)
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  def roles
    ROLES.reject { |r| ((roles_mask || 0) & 2**ROLES.index(r)).zero? }
  end

  def self.with_role(role)
    where('roles_mask & ? > 0', 2**ROLES.index(role.to_s))
  end

  def role?(role)
    roles.include? role.to_s
  end

  private

  def init_role
    self.roles_mask = 2
  end
end
