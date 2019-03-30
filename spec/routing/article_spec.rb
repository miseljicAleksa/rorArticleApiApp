require 'rails_helper'

describe 'articles routes' do
    it 'should route to article routes' do
        expect(get '/articles').to route_to('articles#index')
    end
end