class EvaluationsController < ApplicationController
  def create
    code = params[:code]

    render json: {code: code}
  end
end
