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
    token = request.headers['token']
    bugs_count = Bug.cached_count_for(token) if token

    if bugs_count
      render json: {
        application_token: token, count: bugs_count
      }.as_json, status: :ok
    else
      render json: { error: 'application not found' }, status: 404
    end
  end

  def create
    begin
      @bug = Bug.create!(bug_params)
    rescue Exception => e
      raise e
    end
    render json: { number: @bug.number }, status: :created, location: @bug
  end

  private

  def set_bug
    token = request.headers['token']
    @bug = Bug.find_by(number: params[:number], application_token: token)
    raise ActiveRecord::RecordNotFound, 'bug not found' unless @bug
  end

  def bug_params
    params.require(:bug).permit(:application_token, :number, :status, :priority,
                                states_attributes: [:device, :os, :memory, :storage])
  end
end
