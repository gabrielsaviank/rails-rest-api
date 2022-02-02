require 'rails_helper'

RSpec.describe ArticlesController do
  describe '#index' do
    it 'returns a success response' do
      get '/articles'
      # expect(response).to eq(200)
      expect(response).to have_http_status(:ok)
    end

    it 'should return a proper JSON' do
      article = create :article
      get '/articles'
      expected = json_data.first
      aggregate_failures do
        expect(expected[:id]).to eq(article.id)
        expect(expected[:type]).to eq('article')
        expect(expected[:attributes]).to eq(
          title: article.title,
          content: article.content,
          slug: article.slug
        )
      end
    end

    it 'returns articles in the proper order' do
      recent_article = create(:article)
      older_article =
        create(:article, created_at: 1.hour.ago)
      get '/articles'
      ids = json.data.map { |item| item[:id].to_i }
      expect(ids).to eq([recent_article.id, older_article.id])
    end
  end
end
