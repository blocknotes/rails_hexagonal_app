# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :load_post, only: %i[show edit publish update destroy]

  # GET /posts
  def index
    @posts = Posts::ListService.call
  end

  # GET /posts/export
  def export
    Posts::ExportService.call(listeners: [self])
  end

  def export_success(csv_data)
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
    Posts::PublishService.call(post: @post, listeners: [self])
  end

  def publish_failure(post, message)
    notice = message == :already_published ? 'Post already published.' : 'Post was not successfully published.'
    respond_to do |format|
      format.html { redirect_to post, notice: notice }
    end
  end

  def publish_success(post)
    respond_to do |format|
      format.html { redirect_to post, notice: 'Post was successfully published.' }
    end
  end

  # POST /posts
  def create
    Posts::CreateService.call(attrs: post_params, listeners: [self])
  end

  def create_failure(post)
    @post = post
    respond_to do |format|
      format.html { render :new }
    end
  end

  def create_success(post)
    respond_to do |format|
      format.html { redirect_to post, notice: 'Post was successfully created.' }
    end
  end

  # PATCH/PUT /posts/1
  def update
    Posts::UpdateService.call(post: @post, attrs: post_params, listeners: [self])
  end

  def update_failure(post)
    respond_to do |format|
      format.html { render :edit }
    end
  end

  def update_success(post)
    respond_to do |format|
      format.html { redirect_to post, notice: 'Post was successfully updated.' }
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
