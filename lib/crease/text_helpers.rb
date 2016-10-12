module Crease
  module TextHelpers

    def increased
      Crease::Builder.new(tense: :past)
    end

    alias_method :decreased, :increased

    def an
      Crease::Builder.new(context: :an)
    end

    def a
      Crease::Builder.new(context: :a)
    end

  end
end
