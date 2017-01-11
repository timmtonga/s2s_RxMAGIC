require 'digest/sha1'
require 'digest/sha2'

class User < ActiveRecord::Base

  validates :username, presence: true, uniqueness: true, length: { minimum: 5 }
  validates :first_name, presence: true
  validates :fathers_name, presence: true
  validates :mothers_name, presence: true
  validates :role, presence: true
  validates :password, presence: true, length: { minimum: 6 }

  before_save :encrypt_password

  cattr_accessor :current

  def self.get_similar_user(username)
    users = User.where("username LIKE ?", "%#{username}%")
    return users
  end

  def display_name
    (self.first_name.blank? ? '' : self.first_name) + " " + (self.middle_name.blank? ? '' : self.middle_name) + " " +
        (self.fathers_name.blank? ? '' : self.fathers_name)
  end

  def fullname
    (self.first_name.blank? ? '' : self.first_name) + " " + (self.middle_name.blank? ? '' : self.middle_name) + " " +
        (self.fathers_name.blank? ? '' : self.fathers_name) + " " + (self.mothers_name.blank? ? '' : self.mothers_name)
  end

  def self.random_string(len)
    #generat a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end

  def encrypt_password
    if salt.blank?
      self.salt = User.random_string(10)
      self.password = encrypt(self.password, self.salt)
    end
  end

  def encrypt(password,salt)
    Digest::SHA1.hexdigest(password+salt)
  end

  def self.authenticate(username, password)

    user = User.find_by_username(username) rescue nil

    if !user.nil?

      salt = Digest::SHA1.hexdigest(password + user.salt)

      if salt == user.password

        return true
      else
        return false
      end

    else

      return false

    end

  end

end