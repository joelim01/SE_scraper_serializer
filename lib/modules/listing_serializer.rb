module Serializable
  require 'oj'

  def serialize
    Oj::dump self, :indent => 2, :mode => :compat
  end

end
