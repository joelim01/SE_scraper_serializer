class ListingSerializer
  require 'oj'

  def self.serialize(object)
    Oj::dump object, :indent => 2, :mode => :compat
  end

end
