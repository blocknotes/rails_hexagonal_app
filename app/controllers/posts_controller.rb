# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :load_post, only: %i[show edit publish update destroy]

  # GET /posts
  def index
    @posts = Posts::ListService.call
  end

  # GET /posts/export
  def export
    csv_data = Posts::ExportService.call

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
      if Posts::PublishService.call(post: @post)
        format.html { redirect_to @post, notice: 'Post was successfully published.' }
      else
        format.html { redirect_to @post, notice: 'Post already published.' }
      end
    end
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if Posts::UpdateService.call(post: @post)
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    respond_to do |format|
      if Posts::UpdateService.call(post: @post, attrs: post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    Posts::DestroyService.call(post: @post)
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private

  def load_post
    @post = Posts::LoadService.call(params[:id])
  end

  def post_params
    params.fetch(:post) { {} }.permit!
  end
end
