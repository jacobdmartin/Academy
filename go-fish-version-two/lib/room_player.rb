require_relative '../lib/room'
require_relative '../lib/server'
require_relative '../lib/game'

class RoomPlayer
  attr_accessor :client, :player, :name
  def initialize(name, client)
    @name = name
    @client = client
  end
end