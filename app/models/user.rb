# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :name, :email, :password, :password_confirmation

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  # commented out to ensure a red test
  validates :name, :presence => true,
  :length => { :maximum => 50 }
  validates :email, :presence => true,
  :format => {:with => email_regex},
  :uniqueness => { :case_sensitive => false }
  
  #Automagically create the virtual attribute 'password_confirmation'
  validates :password, :presence => true,
  :confirmation => true,
  :length => { :within => 6..40 }

  before_save :encrypt_password

  # Return true if the user's password matches the submitted password
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

#  def self.authenticate(email, submitted_password) #class method, Original
#  ## User in place of self (Listing 7.27)
#  #def User.authenticate(email,submitted_password)
#    user = find_by_email(email)
#    return nil if user.nil?
#    return user if user.has_password?(submitted_password)
#    ## Explicit third return (Listing 7.28)
#    #return nil
#  end

## using if statement (Listing 7.29)
#def self.authenticate(email, submitted_password)
#  user = find_by_email(email)
#  if user.nil?
#    nil
#  elsif user.has_password?(submitted_password)
#    user
#    # Explicit or implcit return (Listing 7.30)
#    #  else
#    #    nil
#  end
#end

## Using ternary operator, most comact (Listing 7.31)
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    user && user.has_password?(submitted_password) ? user : nil
  end

<<<<<<< .merge_file_4LrU2S
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
=======

>>>>>>> .merge_file_Jhfn0f

  # start of private methods
  private
  def encrypt_password
    self.salt = make_salt unless has_password?(password)
    self.encrypted_password = encrypt(password)
  end

  def encrypt(string)
    string # Only a stub implementation
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

end
