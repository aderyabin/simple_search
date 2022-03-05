# frozen_string_literal: true

class RepoSearchController < ApplicationController
  def index
    @repo_search = Github::RepoSearch.call(query: params[:q], page: params[:page], per_page: params[:per_page])
    flash[:notice] = @repo_search.message if @repo_search.failure?
  end
end
