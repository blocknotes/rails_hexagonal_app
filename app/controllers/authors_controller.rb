# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :load_author, only: %i[show]

  # GET /authors/1
  def show; end

  private

  def load_author
    @author = Author.find(params.require(:id))
  end
end
