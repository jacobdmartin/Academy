require_relative '../lib/room'
require_relative '../lib/game'
require_relative '../lib/room_player'
require_relative '../lib/server'
require_relative '../lib/results'
require 'socket'
require 'pry'

class MockGoFishClient
  attr_reader :socket
  attr_reader :output

  def initialize
    @socket = TCPSocket.new('localhost', port_number)
  end

  def provide_input(text)
    socket.puts(text)
  end

  def capture_output(delay=0.1)
    sleep(delay)
    output = socket.read_nonblock(1000) # not gets which blocks
  rescue IO::WaitReadable
    output = ""
  end

  def close
    socket.close if @socket
  end
end

describe 'GameRoom' do

  before(:each) do
    @clients_in_lobby = []
    @server = GoFishServer.new
    @server.start
  end

  after(:each) do
    @server.stop
    @clients_in_lobby.each do |client|
      client.close
    end
  end

  def port_number
    3336
  end

  def ip_address
    'localhost'
  end

  def initialize_new_game
    @game = GoFishGame.new
    @game.start
  end

  def initialize_new_room
    @room = GameRoom.new("Jake")
    @room
  end

  # let(:client1) {RoomPlayer.new("Jake")}
  # let(:client2) {RoomPlayer.new("Josh")}
  # let(:client3) {RoomPlayer.new("Daniel")}

  describe '#start_game' do
    it 'starts a game' do
      client1 = MockGoFishClient.new
      client1.provide_input(["Jake"])
      client1 = RoomPlayer.new(client1.capture_output, client1)
      client2 = MockGoFishClient.new
      client2.provide_input(["Josh"])
      client2 = RoomPlayer.new(client2.capture_output, client2)
      client3 = MockGoFishClient.new
      client3.provide_input(["Daniel"])
      client3 =RoomPlayer.new(client3.capture_output, client3)
      room = GameRoom.new([client1, client2, client3])
      game = room.start_game
      expect(game).to_not be_nil
    end
  end

  describe "#assign_players_to_room_players" do
    it 'returns true if a player and a room player have the same name' do
      client = MockGoFishClient.new
      client.provide_input(["Nia"])
      room_player = RoomPlayer.new(client.capture_output, client)
      @room = GameRoom.new([room_player])
      @room.game = GoFishGame.new([room_player])
      @room.assign_players_to_room_players
      expect(@room.room_players[0]).to eq @room.game.players[0]
    end
  end

  describe '#client_input' do
    it 'returns string if a given player is the current player' do
      
    end
  end
  

  describe '#play_round' do 
    it 'returns true if every player has had a turn, which completes the round' do
      #to do
    end
  end

  describe '#play_game' do
    it 'returns true when a game has been played' do
      #to do
    end
  end

  describe '#display_message_to_client' do
    it 'displays a given message to the client' do
      #to do
    end
  end

  describe '#display_message_to_group' do
    it 'displays a given message to the group in the game' do
      #to do
    end
  end
end