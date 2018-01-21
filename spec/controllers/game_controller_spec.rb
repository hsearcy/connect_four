require 'rails_helper'

RSpec.describe GameController, type: :controller do
  before(:all) do
    Rails.application.load_seed
  end

  let(:blank_board) do
    [[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ]]
  end

  describe 'index' do
    before do
      get :index
    end

    it 'returns successfully' do
      expect(response.status).to eq(200)
    end
  end

  describe 'new' do
    context 'without an ID' do
      let(:game_params) do
        { mode: 1, id: nil }
      end

      before do
        post :new, params: game_params
      end

      it 'returns successfully' do
        expect(response.status).to eq(200)
      end

      it 'returns a blank game' do
        json_body = JSON.parse(response.body)
        expect(json_body['boardstatus']).to eq(blank_board)
      end
    end

    context 'with a non-existing ID' do
      let(:game_params) do
        { mode: 1, id: 321 }
      end

      before do
        post :new, params: game_params
      end

      it 'returns successfully' do
        expect(response.status).to eq(200)
      end

      it 'returns a blank game' do
        json_body = JSON.parse(response.body)
        expect(json_body['boardstatus']).to eq(blank_board)
      end
    end

    context 'with an existing ID' do
      let(:game_params) do
        { mode: 1, id: Game.first }
      end

      before do
        post :new, params: game_params
      end

      it 'returns successfully' do
        expect(response.status).to eq(200)
      end

      it 'returns a saved game' do
        json_body = JSON.parse(response.body)
        expect(json_body['boardstatus']).to eq([[ 1, 1, 1, 1, 0, 0 ],[ 2, 2, 2, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ]])
      end
    end
  end

  describe 'move' do
    let(:game_params) do
      { mode: 1, id: nil }
    end

    before do
      post :new, params: game_params
      json_body = JSON.parse(response.body)
      puts json_body
      post :move, params: { id: json_body['id'], moveCol: 3 }
    end

    it 'returns successfully' do
      expect(response.status).to eq(200)
    end

    it 'returns an updated board' do
      json_body = JSON.parse(response.body)
      expect(json_body['boardstatus']).to eq([[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 1, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ]])
    end

    it 'returns updated move' do
      json_body = JSON.parse(response.body)
      expect(json_body['move']).to eq(2)
    end

    it 'returns winner = 0' do
      json_body = JSON.parse(response.body)
      expect(json_body['winner']).to eq(0)
    end
  end
    
end
