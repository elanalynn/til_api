require 'rails_helper'

RSpec.describe 'Item API', type: :request do
  let(:user) { create(:user) }
  let(:item) { create(:item, user_id: user.id) }
  let(:headers) { valid_headers }
  
  describe 'GET /items' do
    let!(:items) { create_list(:item, 10, user_id: user.id) }
    before { get '/items', headers: headers }

    it 'returns items' do
      expect(body).not_to be_empty
      expect(body.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /items/:id' do
    context 'when the record exists' do
      before { get "/items/#{item.id}", headers: headers }

      it 'returns the item' do
        expect(body).not_to be_empty
        expect(body['id']).to eq(item.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get "/items/12345", headers: headers }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Item/)
      end
    end
  end

  describe 'POST /items' do
    let(:item) { create(:item, content: 'Request specs provide a thin wrapper around Rails integration tests.') }
    let(:valid_attributes) do
       { content: item.content, date: item.date }.to_json
    end

    context 'when the request is valid' do
      before { post '/items', params: valid_attributes, headers: headers }

      it 'creates an item' do
        expect(body['content']).to eq('Request specs provide a thin wrapper around Rails integration tests.')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/items', params: { content:'abc' }.to_json, headers: headers }

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
    let(:item) { create(:item, content:'Faker library that generates fake data') }
    let(:valid_attributes) do
      { content: item.content, date: item.date }.to_json
    end

    context 'when the record exists' do
      before { put "/items/#{item.id}", params: valid_attributes, headers: headers }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /items/:id' do
    before { delete "/items/#{item.id}", headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
