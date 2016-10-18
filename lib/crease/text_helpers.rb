module Crease
  module TextHelpers

    def increased
      Crease::Builder.new(tense: :past)
    end

    alias_method :decreased, :increased

    def an
      Crease::Builder.new(before: :an)
    end

    def a
      Crease::Builder.new(before: :a)
    end

    def changed
      Crease::Builder.new(subject: :change, tense: :past)
    end

  end
end
