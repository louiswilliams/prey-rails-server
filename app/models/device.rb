class Device < ActiveRecord::Base
  attr_accessible :account, :delay, :device_id, :missing, :modules, :name
end
