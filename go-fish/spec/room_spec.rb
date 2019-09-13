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

  def initialize(port)
    @socket = TCPSocket.new('localhost', port)
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

  # let(:client1) {MockGoFishClient.new(@server.port_number)}
  # let(:client2) {MockGoFishClient.new(@server.port_number)}
  # let(:client3) {MockGoFishClient.new(@server.port_number)}

  def initialize_three_players
    @client1 = MockGoFishClient.new(@server.port_number)
    @client2 = MockGoFishClient.new(@server.port_number)
    @client3 = MockGoFishClient.new(@server.port_number)
  end

  def clients_enter_ready?(*clients)
    clients.each {|client| client.provide_input("Ready")}
    true
  end

  describe '#start_game' do
    it 'starts a game' do
      initialize_three_players
      room = GameRoom.new(@clients)
      clients_enter_ready?(@client1, @client2, @client3)
      game = room.start_game
      expect(game).to eq true
    end
  end

  describe '#players_ready' do
    it 'returns true when three people all provide the input "Ready' do
      initialize_three_players
      room = GameRoom.new(@clients)
      expect(clients_enter_ready?(@client1, @client2, @client3)).to eq true
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