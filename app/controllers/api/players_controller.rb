module API
  class PlayersController < ApplicationController

    def index
      players = Player.all
      if team = params[:team]
        players = players.where(team: team)
      end
      render json: players, status: :ok
    end

    def show
      player = Player.find(params[:id])
      render json: player, status: :ok
    end

    def create
      Player.create!(name: params[:name], team: params[:team])
      render json: 'success', status: :ok
    end
  end
end
