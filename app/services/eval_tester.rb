class EvalTester
  attr_reader :sb, :rules, :app
  def initialize(code, rules = {})
    @rules = rules
    @code = code
    @sb = Sandbox.new
    @classed = "class Application\n" + code + "\nend"
  end

  def run
    # need a timeout!
    res = sb.run(@classed)
    @app = sb.base_namespace::Application.new
    res
  end

  def test
    results = {}
    rules.each do |name, rule|
      results[name] = app.send(:name) == rule
    end
    results
  end
end
