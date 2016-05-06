class BugsController < ApplicationController
  before_action :set_bug, only: [:show, :update, :destroy]

  def index
    @bugs = Bug.all.order(priority: :desc)

    render json: @bugs
  end

  def show
    render json: @bug
  end

  def count
    token = request.headers['token']
    bugs_count = Bug.where(application_token: token).count if token

    if bugs_count
      render json: { application_token: token, count: bugs_count }.as_json
    else
      render json: { error: 'application not found' }, status: 404
    end
  end

  def create
    @bug = Bug.new(bug_params)

    if @bug.save
      render json: { number: @bug.number }, status: :created, location: @bug
    else
      render json: @bug.errors, status: :unprocessable_entity
    end
  end

  def update
    @bug = Bug.find(params[:id])

    if @bug.update(bug_params)
      head :no_content
    else
      render json: @bug.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @bug.destroy

    head :no_content
  end

  private

  def set_bug
    @bug = Bug.find_by_number(params[:number])

    render json: { error: 'bug not found' }, status: 404 unless @bug
  end

  def bug_params
    params.require(:bug).permit(:application_token, :number, :status, :priority,
                                states_attributes: [:device, :os, :memory, :storage])
  end
end
