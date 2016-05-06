class StatesController < ApplicationController
  before_action :set_state, only: [:show, :update, :destroy]

  def index
    @states = State.all

    render json: @states
  end

  def show
    render json: @state
  end

  def create
    @state = State.new(state_params)

    if @state.save
      render json: @state, status: :created, location: @state
    else
      render json: { error: @state.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @state = State.find(params[:id])

    if @state.update(state_params)
      head :no_content
    else
      render json: { error: @state.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @state.destroy

    head :no_content
  end

  private

    def set_state
      @state = State.find(params[:id])
    end

    def state_params
      params.require(:state).permit(:device, :os, :memory, :storage, :bug_id)
    end
end
