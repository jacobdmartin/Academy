require 'pry'

describe 'GoFishServer' do

  def create_two_clients 
    @client1 = MockGoFishClient.new(@server.port_number)
    @server.accept_new_client
    @client2 = MockGoFishClient.new(@server.port_number)
    @server.accept_new_client
  end

  def create_three_clients 
    @client1 = MockGoFishClient.new(@server.port_number)
    @server.accept_new_client
    @client2 = MockGoFishClient.new(@server.port_number)
    @server.accept_new_client
    @client3 = MockGoFishClient.new(@server.port_number)
    @server.accept_new_client
  end

  before(:each) do
    @clients_in_lobby = []
    @server = GoFishServer.new
  end

  after(:each) do
    @server.stop
    @clients_in_lobby.each do |client|
      client.close
    end
  end

  it "is not listening on a port before it is started"  do
    expect {MockGoFishClient.new(@server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  describe '#start' do
    it 'returns true if the server starts' do
      @server.start
      expect(@server).to_not be_nil
    end
  end

  describe '#stop' do
    it 'returns true if the server stops' do
      @server.start
      @server.stop
      expect(@server.closed?).to eq true
    end
  end
#what just broke, and why didn't the test catch
#can I write a test to fix that
  describe '#closed?' do
    it 'makes sure my closed? method does not run if the server has not started' do
      #to do
    end
  end

  describe '#accept_new_client' do
    it "accepts 2 new clients" do
      @server.start
      create_two_clients
      expect(@server.clients_in_lobby.count).to eq 2
      expect(@server.rooms.count).to eq 0
    end
  end

  describe '#create_room_if_possible' do
    it 'expects a room to be created and a game running when clients_in_lobby equals 3' do
      @server.start
      create_three_clients
      expect(@server.rooms.count).to eq 1
      expect(@server.clients_in_lobby.count).to eq 0
    end
  
    it 'allows multiple rooms on one server' do
      @server.start
      create_three_clients
      create_three_clients
      expect(@server.rooms.count).to eq 2
    end

    it 'allows multiple rooms on one server and still contains people in the lobby' do
      @server.start
      create_three_clients
      create_two_clients
      expect(@server.rooms.count).to eq 1
      expect(@server.clients_in_lobby.count).to eq 2
    end
  end
end