class Micropost < ActiveRecord::Base

   attr_accessible :content  ## Único que pode ser editado através da Web

   # Relacionamentos
   
   belongs_to :user

   # Validações
  
   validates :content, :presence => true, :length => { :maximum => 140 }
   validates :user_id, :presence => true

   # Escopo
   
   default_scope :order => 'microposts.created_at DESC'

end
