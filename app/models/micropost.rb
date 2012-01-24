class Micropost < ActiveRecord::Base

   attr_accessible :content  ## Único que pode ser editado através da Web

   # Relacionamentos
   
   belongs_to :user

   # Validações
  
   validates :content, :presence => true, :length => { :maximum => 140 }
   validates :user_id, :presence => true

   # Escopo
   
   default_scope :order => 'microposts.created_at DESC'

   ## Return microposts from the users being followed by given user.
   scope :from_users_followed_by, lambda { |user| followed_by(user) }

   # Methods
#
# Substituido por ** scope **: from_users_by
#
#   def self.from_users_followed_by(user)
#      where( :user_id => user.following.push(user))
#   end

   ## 
   private
   
     # Return an SQL condition for users followed by the given user.
     # We include the user's own id as well.
     def self.followed_by(user)
        following_ids = %(SELECT followed_id FROM relationships WHERE follower_id = :user_id) ## user.following_ids
        where("user_id IN (#{following_ids}) OR user_id = :user_id", { :user_id => user })
     end

end
