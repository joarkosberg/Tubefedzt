class User < ActiveRecord::Base
  ROLES = %w[admin user].freeze
  PROVIDER = 'facebook'
  has_many :votes
  after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :trackable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name
      user.profile_picture = URI.parse(picture_from_url(auth.info.image))
      user.save!
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def admin?
    self.role == ROLES[0]
  end

  # Check if user is logged in with Facebook-account
  def from_facebook?
    self.provider == PROVIDER
  end

  # This method associates the attribute ":profile_picture" with a file attachment
  has_attached_file :profile_picture, styles: {
      thumb: '100x100>',
      square: '150x150#',
      medium: '200x200>'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :profile_picture, :content_type => /\Aimage\/.*\Z/

  private

  # Send welcome email to user
  def send_welcome_email
    UserMailer.welcome_email(self).deliver
  end

  # Allow redirections from HTTP to HTTPS
  # Needs this to download FB profile picture
  def self.picture_from_url(url)
    require 'open-uri'
    require 'open_uri_redirections'

    open(url, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end
end
