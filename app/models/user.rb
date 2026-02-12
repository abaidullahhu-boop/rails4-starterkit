class User < ActiveRecord::Base
  include UserImagesConcern

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :timeoutable, :lockable

  has_many :authentications, dependent: :destroy, validate: false, inverse_of: :user do
    def grouped_with_oauth
      includes(:oauth_cache).group_by {|a| a.provider }
    end
  end

  after_create :send_welcome_emails

  # Some legacy records (or partially-created users from earlier failed
  # upgrades) may have an `encrypted_password` that is not a valid
  # BCrypt hash for the current bcrypt version. When Devise calls
  # `valid_password?`, BCrypt will raise `BCrypt::Errors::InvalidHash`.
  # To avoid hard failures during signup/login, we treat such hashes as
  # simply invalid credentials.
  def valid_password?(password)
    super
  rescue BCrypt::Errors::InvalidHash
    false
  end

  def display_name
    first_name.presence || email.split('@')[0]
  end

  # Case insensitive email lookup.
  #
  # See Devise.config.case_insensitive_keys.
  # Devise does not automatically downcase email lookups.
  def self.find_by_email(email)
    find_by(email: email.downcase)
    # Use ILIKE if using PostgreSQL and Devise.config.case_insensitive_keys=[]
    #where('email ILIKE ?', email).first
  end

  # Override Devise to allow for Authentication or password.
  #
  # An invalid authentication is allowed for a new record since the record
  # needs to first be saved before the authentication.user_id can be set.
  def password_required?
    if authentications.empty?
      super || encrypted_password.blank?
    elsif new_record?
      false
    else
      super || encrypted_password.blank? && authentications.find{|a| a.valid?}.nil?
    end
  end

  # Merge attributes from Authentication if User attribute is blank.
  #
  # If User has fields that do not match the Authentication field name,
  # modify this method as needed.
  def reverse_merge_attributes_from_auth(auth)
    auth.oauth_data.each do |k, v|
      self[k] = v if self.respond_to?("#{k}=") && self[k].blank?
    end
  end

  # Do not require email confirmation to login or perform actions
  def confirmation_required?
    false
  end

  def send_welcome_emails
    # Original app used Sidekiq/Redis via `delay`, which is not wired up
    # (and uses legacy Redis APIs). For now, send the welcome email
    # synchronously to avoid background job/Redis issues.
    UserMailer.welcome_email(self).deliver_now
  end
end
