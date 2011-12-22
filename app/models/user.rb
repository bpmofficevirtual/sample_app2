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
require 'digest'   ## Para ENCRYPT! (necessário em algums sistemas)

class User < ActiveRecord::Base

   # Atributos
   attr_accessor   :password  ## ATRIBUTO VIRTUAL

   # Questão de segurança do site : :admin não está acessível! (put /users/17?admin=1 não irá operar!)
   attr_accessible :name, :email, :password, :password_confirmation 

   # Relacionamentos
   has_many :microposts, :dependent => :destroy


   # Validações
   email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

   validates :name,  :presence => true,
		     :length   => { :maximum => 50 }

   validates :email, :presence   => true,
		     :format     => { :with => email_regex },
		     :uniqueness => { :case_sensitive => false }


   validates :password, :presence     => true,
                        :confirmation => true,
		        :length       => { :within => 6..40 }


   # Callbacks
   before_save :encrypt_password

   # Return true if the user's password matches the submitted password.
   def has_password?(submitted_password)
     # Compare encrypted_password with the encrypted version of
     # submitted_password
     encrypted_password == encrypt(submitted_password)
   end

   def self.authenticate(email, submitted_password) ## MÉTODO DE CLASSE: self

     user = find_by_email(email)
     return nil  if user.nil?
     return user if user.has_password?(submitted_password)
   end

   def self.authenticate_with_salt(id, cookie_salt)
     user = find_by_id(id)
     (user && user.salt == cookie_salt) ? user : nil
   end
   ################################################

   def feed
      # This is preliminary.
      Micropost.where("user_id = ?", id)
   end

   ################################################
   private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)  ## **SELF** é obrigatório caso contrário será criada uma variável LOCAL!
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
       secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
       Digest::SHA2.hexdigest(string)
    end
   ################################################

end
