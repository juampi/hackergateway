# frozen_string_literal: true

class ChallengesController < ApplicationController
  before_action :set_challenge, only: :show

  # GET /challenges
  # GET /challenges.json
  def index
    @categories = Category.includes(:challenges).all
  end

  # GET /challenges/1
  # GET /challenges/1.json
  def show
    eval(@challenge.code) if @challenge.code?
    @solution = Solution.new
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_challenge
    @challenge = Challenge.friendly.find(params[:id])
  end
end
