class EvaluationsController < ApplicationController
  def create
    code = params[:code]

    eval_test = EvalTester.new(code)

    begin
      res = eval_test.run
      test_results = eval_test.test
    rescue SecurityError => e
      val = { code: "SecurityError: " + e.message }
      render json: val
    rescue SyntaxError => e
      val = { code: e.message }
      render json: val
    rescue NoMethodError => e
      # pretty_message = Sandbox.prettify(e)
      render json: {code: e.message}
    else
      render json: { code: res.inspect }
    end
  end
end
