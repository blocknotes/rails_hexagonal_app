# frozen_string_literal: true

require 'csv'

class PostsController < ApplicationController
  before_action :load_post, only: %i[show edit publish update destroy]

  # GET /posts
  def index
    @posts = Post.includes(:author).all.to_a
  end

  # GET /posts/export
  def export
    posts = Post.all.annotate('export posts').to_a
    columns = ['Title', 'Author', 'Published at']
    csv = []
    csv << CSV.generate_line(columns)
    csv += posts.map { |post| CSV.generate_line([post.title, post.author.name, post.published_at]) }
    csv_data = csv.join

    respond_to do |format|
      format.csv do
        response.headers['Content-Type'] = 'text/csv'
        response.headers['Content-Disposition'] = 'attachment; filename=export.csv'
        render inline: csv_data
      end
    end
  end

  # GET /posts/1
  def show; end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts/1/publish
  def publish
    respond_to do |format|
      if !@post.published_at.nil?
        format.html { redirect_to @post, notice: 'Post already published.' }
      elsif @post.update(published_at: Time.now)
        format.html { redirect_to @post, notice: 'Post was successfully published.' }
      else
        format.html { render :edit }
      end
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.fetch(:post) { {} }.permit!
  end
end
