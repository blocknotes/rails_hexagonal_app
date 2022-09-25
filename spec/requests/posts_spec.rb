# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'posts listing' do
    it 'shows the list of posts' do
      get '/'
      expect(response).to render_template(:index)
    end
  end

  describe 'post editing' do
    let!(:post) { Post.create!(author: author, title: 'Some post') }

    let(:author) { Author.new(email: 'some@email.it') }

    it 'shows the post fields' do
      get "/posts/#{post.id}/edit"
      expect(response).to render_template(:edit)
    end
  end

  describe 'post details' do
    let!(:post) { Post.create!(author: author, title: 'Some post') }

    let(:author) { Author.new(email: 'some@email.it') }

    it 'shows the post details' do
      get "/posts/#{post.id}"
      expect(response).to render_template(:show)
    end
  end
end
