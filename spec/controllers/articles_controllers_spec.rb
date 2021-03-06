require 'rails_helper'

describe ArticlesController do
    describe '#index' do
       subject {get :index}
        it 'should return success response' do
            subject
            expect(response).to have_http_status(:ok)
        end
        it 'should return propper json' do
            create_list :article, 2
            subject
            Article.recent.each_with_index do |article, index|
            expect(json_data[index]['attributes']).to eq({
                "title" => article.title,
                "content" => article.content,
                "slug" => article.slug
                })
            end 
        end

        it 'should return articles in proper order' do
        older_article = create :article
        newer_article = create :article
        subject
        expect(json_data.first['id']).to eq(newer_article.id.to_s)
        expect(json_data.last['id']).to eq(older_article.id.to_s)
        end
        it 'should paginate results' do
            create_list :article, 3
            get :index,  params: {page: 2, per_page: 1}
            expect(json_data.length).to eq 1
            expect(json_data.first['id']).to eq(Article.recent.second.id.to_s)
        end
    end

    describe '#show' do
        let(:article) { create :article }
        subject { get :show, params: {id: article.id} }

        it 'should return success response' do
            subject
            expect(response).to have_http_status(:ok)
        end

        it 'should return proper json' do
            subject
            expect(json_data['attributes']).to eq({
                "title" => article.title,
                "content" => article.content,
                "slug" => article.slug
            })
        end
    end

    describe '#create' do
        subject { post :create }

        context 'when no code provided' do
            it_behaves_like 'forbidden_requests'

        end
        context 'when invalid code provided' do
            before { request.headers['authorization'] = 'Invalid token'}
            it_behaves_like 'forbidden_requests'
        end
    end
end