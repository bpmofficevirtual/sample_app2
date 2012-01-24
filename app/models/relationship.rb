class Relationship < ActiveRecord::Base
  attr_accessible :followed_id ## cris: follower_id não acessível via Web!! para não permitir que alguém consiga "criar seguidores"

  # Relacionamentos
  belongs_to :follower, :class_name => "User"
  belongs_to :followed,  :class_name => "User"
 
  # Validações
  validates :follower_id, :presence => true
  validates :followed_id, :presence => true
end
