require 'rails_helper'

RSpec.describe 'TIL API', type: :request do
  let!(:items) { create_list(:item, 10) }
  let(:item_id) { items.first.id }

  describe 'GET /items' do
    before { get '/items' }

    it 'returns items' do
      expect(json).not_to be_empty
      expect(json.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /items/:id' do
    before { get "/items/#{item_id}" }

    context 'when the record exists' do
      it 'returns the item' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(item_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:item_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /items' do
    let(:valid_attributes) { { content: 'Request specs provide a thin wrapper around Rails\' integration tests, and are designed to drive behavior through the full stack.', date: Date.today } }

    context 'when the request is valid' do
      before { post '/items', params: valid_attributes }

      it 'creates an item' do
        expect(json['content']).to eq('Request specs provide a thin wrapper around Rails\' integration tests, and are designed to drive behavior through the full stack.')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/items', params: { content: 'Invalid?' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Date can't be blank/)
      end
    end
  end

  describe 'PUT /items/:id' do
    let(:valid_attributes) { { content: 'Faker library that generates fake data.' } }

    context 'when the record exists' do
      before { put "/items/#{item_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /items/:id' do
    before { delete "/items/#{item_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
