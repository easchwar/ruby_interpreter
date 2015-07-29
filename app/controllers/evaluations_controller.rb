class EvaluationsController < ApplicationController
  def create
    code = params[:code]
    
    sb = Sandbox.new

    begin
      res = sb.run(code)
    rescue SecurityError => e
      res = "SecurityError: disallowed operation"
    rescue SyntaxError => e
      res = "Whoops! Something went wrong!"
    end

    render json: {code: res}
  end
end
