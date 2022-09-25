# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  describe 'posts listing' do
    let(:author) { Author.new(email: 'some@email.it') }

    before do
      3.times { |i| Post.create!(author: author, title: "Some post #{i + 1}") }
    end

    it 'shows the list of posts', :aggregate_failures do
      visit '/posts'
      posts = find_all('li >.title')
      expect(posts.size).to eq 3
      expect(page).to have_css('li >.title', text: 'Some post 1')
      expect(page).to have_css('li >.title', text: 'Some post 2')
      expect(page).to have_css('li >.title', text: 'Some post 3')
    end
  end

  describe 'post editing' do
    let!(:post) { Post.create!(author: author, title: 'Some title') }

    let(:author) { Author.new(email: 'some@email.it') }

    it 'shows the post fields', :aggregate_failures do
      visit "/posts/#{post.id}/edit"
      expect(page).to have_css('#post_title[value="Some title"]')

      fill_in('post[title]', with: 'Another title')
      find('input[type="submit"]').click
      expect(page.current_url).to eq "http://www.example.com/posts/#{post.id}"
      expect(page).to have_css('.item', text: 'Title: Another title')
    end
  end

  describe 'post details' do
    let!(:post) { Post.create!(author: author, title: 'Some post') }

    let(:author) { Author.new(email: 'some@email.it') }

    it 'shows the post details' do
      visit "/posts/#{post.id}"

      expect(page).to have_css('.item', text: 'Title: Some post')
    end
  end

  describe 'post publish', :freeze_time do
    let!(:post) { Post.create!(author: author, title: 'Some post', published_at: nil) }

    let(:author) { Author.new(email: 'some@email.it') }

    it 'publish the post', :aggregate_failures do
      visit "/posts/#{post.id}"
      click_on 'Publish'

      expect(page.current_url).to eq "http://www.example.com/posts/#{post.id}"
      expect(page).to have_css('.item', text: "Published at: #{Time.current}")
      expect(page).to have_css('.notice', text: 'Post was successfully published.')

      click_on 'Publish'
      expect(page).not_to have_css('.notice', text: 'Post was successfully published.')
      expect(page).to have_css('.notice', text: 'Post already published.')
    end
  end

  describe 'post export' do
    let(:author) { Author.new(email: 'some@email.it') }

    before do
      3.times { |i| Post.create!(author: author, title: "Some post #{i + 1}") }
    end

    it 'exports the list of posts' do
      visit '/posts/export.csv'

      expect(body).to eq <<~CSV
        Title,Author,Published at
        Some post 1,,
        Some post 2,,
        Some post 3,,
      CSV
    end
  end
end
