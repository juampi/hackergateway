class User < ApplicationRecord # :nodoc:
  extend FriendlyId
  friendly_id :username, use: :slugged

  include Gravtastic
  gravtastic default: "mm"

  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable

  has_many :solutions, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :solved_challenges, through: :solutions, source: :challenge

  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 4, maximum: 15 },
            format: {
              with: /\A[a-zA-Z0-9\-]+\z/,
              message: "only allows letters, numbers and hyphens"
            }
  validates :country_code, inclusion: {
    in: ISO3166::Country.all.map(&:alpha2),
    allow_blank: true,
    message: "is not valid"
  }
  validates :terms_of_service, acceptance: true

  after_create :assign_default_role
  after_validation :move_friendly_id_error_to_username

  def country
    ISO3166::Country[self[:country_code]]
  end

  def solve(challenge)
    solutions.create!(challenge: challenge)
  end

  def solved?(challenge)
    solved_challenges.include? challenge
  end

  def assign_default_role
    add_role(:user) if roles.blank?
  end

  def should_generate_new_friendly_id?
    username_changed?
  end

  def move_friendly_id_error_to_username
    return unless errors[:friendly_id].present?
    errors.add :username, *errors.delete(:friendly_id)
  end
end
