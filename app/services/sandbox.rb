class Sandbox
  CLASSES = [BasicObject, Object, Class,
             Array, Range, Hash, Date,
             String, Symbol,
             Fixnum, Float]
  METHODS = [:new, :puts, :print, :inspect,
             :to_s, :to_i, :to_sym,
             :method_missing, :binding]

  def self.prettify(error)
    reg = / for Shikashi::Sandbox::SandboxBasenamespace(\d+):Module/

    error.message.gsub(reg, "").gsub('local variable or ', "")
      .gsub('method', 'local variable or method')
  end

  def initialize
    @sandbox = Shikashi::Sandbox.new
    @privilege = Shikashi::Privileges.new

    set_privileges
  end

  def base_namespace
    @sandbox.base_namespace
  end

  def run(code)
    @sandbox.run(@privilege, code)
  end


  private

  def set_privileges
    CLASSES.each do |c|
      @privilege.allow_const_read(c)
      @privilege.instances_of(c).allow_all
    end

    METHODS.each do |m|
      @privilege.allow_method(m)
    end
  end
end
