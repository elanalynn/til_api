require 'rails_helper'

RSpec.describe 'Item API', type: :request do
  let(:item) { create(:item) }
  
  describe 'GET /items' do
    before { 
      items = create_list(:item, 10)
      get '/items' 
    }

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
      before { get "/items/#{item.id}" }

      it 'returns the item' do
        expect(body).not_to be_empty
        expect(body['id']).to eq(item.id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      before { get "/items/12345" }

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
    let(:valid_attributes) { { content: item.content, date: item.date, user_id: item.user_id } } 

    context 'when the request is valid' do
      before { post '/items', params: valid_attributes }

      it 'creates an item' do
        expect(body['content']).to eq('Request specs provide a thin wrapper around Rails integration tests.')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/items', params: { content: 'abc' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: User must exist, Date can't be blank/)
      end
    end
  end

  describe 'PUT /items/:id' do
    let(:valid_attributes) { { content: 'Faker library that generates fake data.' } }

    context 'when the record exists' do
      before { put "/items/#{item.id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /items/:id' do
    before { delete "/items/#{item.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
