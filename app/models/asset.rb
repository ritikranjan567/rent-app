class Asset < ApplicationRecord
  serialize :event_tags
  belongs_to :user
end
