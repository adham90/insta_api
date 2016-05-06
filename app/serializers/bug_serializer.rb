class BugSerializer < ActiveModel::Serializer
  attributes :id, :application_token, :number, :priority
  has_many :states
end
