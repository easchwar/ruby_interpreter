class EvaluationsController < ApplicationController
  def create
    code = params[:code]
    
    sb = Sandbox.new

    begin
      res = sb.run(code)
    rescue SecurityError => e 
      val = { code: "SecurityError: " + e.message }
      render json: val
    rescue SyntaxError => e 
      val = { code: e.message }
      render json: val
    rescue NoMethodError => e
      pretty_message = Sandbox.prettify(e)
      render json: {code: pretty_message}
    else
      render json: { code: res } 
    end

  end
end
