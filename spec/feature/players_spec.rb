describe 'players' do

  it 'return a list of all players', type: :request do
    get api_players_path
    expect(response.status).to eq(200)
    expect(response.body).not_to be_empty
  end

  it 'returns players filtered by team', type: :request do
    Player.create!(name: 'Thierry', team: 'Arse')
    Player.create!(name: 'Bob', team: 'Aldershot')
    get api_players_path(team: 'Arse')
    expect(response.status).to eq(200)
    expect(response.body).to include('Thierry')
    expect(response.body).not_to include('Bob')
  end

  it 'returns player by id', type: :request do
    player = Player.create!(name: 'Tony', team: 'Luton')
    get api_player_path(id: player.id)
    expect(response.status).to eq(200)
    player_response = JSON.parse(response.body, symbolize_names: true)
    expect(player_response[:name]).to eq(player.name)
  end

  it 'returns player data in JSON', type: :request do
    get api_players_path
    expect(response.status).to eq(200)
    expect(response.content_type).to eq(Mime::JSON)
  end

  it 'creates a player', type: :request do
    post api_players_path(name: 'Octo', team: 'Roma')
    expect(response.status).to eq(200)
    expect(Player.first.name).to eq('Octo')
  end

end
