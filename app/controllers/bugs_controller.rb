class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :update, :destroy]

  def index
    @bugs = Bug.all.order(priority: :desc)

    render json: @bugs
  end

  def show
    render json: @bug
  end

  # bugs/count with token header
  def count
    bugs_count = Bug.cached_count_for(token) if token

    if bugs_count
      render json: {
        application_token: token, count: bugs_count
      }.as_json, status: :ok
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def create
    @bug = Bug.create!(bug_params)

    render json: { number: @bug.number }, status: :created, location: @bug
  end

  private

  def set_bug
    @bug = Bug.find_by!(number: params[:number], application_token: token)
  end

  def token
    request.headers['token']
  end

  def bug_params
    params.require(:bug).permit(:application_token, :number, :status, :priority,
                                states_attributes: [:device, :os, :memory, :storage])
  end
end
