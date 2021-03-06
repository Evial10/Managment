class User < ActiveRecord::Base

  validates :first_name, :last_name, :email, :password, presence: true
  mount_uploader :avatar, AvatarUploader
 
  acts_as_authentic do |c|
    c.crypto_provider = Authlogic::CryptoProviders::Sha512
  end

end
