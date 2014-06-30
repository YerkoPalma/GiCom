class Event
  include Mongoid::Document
  field :expositor, type: String
  field :lugar, type: String
  field :fecha, type: Date
  field :categoria, type: String
  field :cliente, type: String

  belongs_to :user
  #embedded_in :user, :inverse_of => :events

  #validates_associated :events

end
