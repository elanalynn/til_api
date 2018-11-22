require 'rails_helper'

RSpec.describe 'Tag API' do
  let(:item) { create(:item) }
  let(:tag) { create(:tag) }

  describe 'GET /items/:item_id/tags' do
    context 'when item exists' do
      before {
        tags = create_list(:tag, 11)
        get "/items/#{item.id}/tags"
      }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all item tags' do
        expect(body.size).to eq(11)
      end
    end

    context 'when item does not exist' do
      before { get "/items/12345/tags" }

      # it 'returns status code 404' do
      #   expect(response).to have_http_status(404)
      # end

      # it 'returns a not found message' do
      #   expect(response.body).to match(/Couldn't find Item/)
      # end
    end
  end

  describe 'GET /items/:item.id/tags/:id' do
    before { get "/items/#{item.id}/tags/#{tag.id}" }

    context 'when tag exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the tag' do
        expect(body['id']).to eq(tag.id)
      end
    end

    context 'when tag does not exist' do
      before { get "/items/#{item.id}/tags/12345" }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tag/)
      end
    end
  end

  describe 'POST /items/:item.id/tags' do
    let(:tag) { create(:tag) }
    let(:valid_attributes) { { label: tag.label, item_id: tag.item_id } }

    context 'when request attributes are valid' do
      before { post "/items/#{item.id}/tags", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/items/#{item.id}/tags", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Label can't be blank/)
      end
    end
  end

  describe 'PUT /items/:item.id/tags/:id' do
    let(:tag) { create(:tag, label: 'react') }
    let(:valid_attributes) { { label: tag.label } }
    before { put "/items/#{item.id}/tags/#{tag.id}", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the tag' do
        updated_tag = Tag.find(tag.id)
        expect(updated_tag.label).to match(/react/)
      end
    end

    context 'when the item does not exist' do
      before { put "/items/#{item.id}/tags/12345", params: valid_attributes }
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Tag/)
      end
    end
  end

  describe 'DELETE /items/:id' do
    before { delete "/items/#{item.id}/tags/#{tag.id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
