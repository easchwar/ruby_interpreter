class Sandbox
  CLASSES = [Array, Hash, String, Fixnum, Float]
  METHODS = [:new, :puts, :print, :inspect] 
  def initialize
    @sandbox = Shikashi::Sandbox.new
    @privilege = Shikashi::Privileges.new
    
    set_privileges
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
