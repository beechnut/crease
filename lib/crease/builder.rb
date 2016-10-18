module Crease
  class Builder

    def initialize(before: nil, subject: nil, after: nil, args: [], percent: false, tense: nil)
      @before  = before
      @subject = subject
      @after   = after
      @args    = args
      @percent = percent
      @tense   = tense

      self
    end

    def increase
      @tense = :present
      self
    end

    alias_method :decrease, :increase

    def change
      @subject = :change
      self
    end

    def by(*args, sigfig: 2)
      @after  = :by
      @args   = args.map(&:to_f)
      @sigfig = sigfig
      self
    end

    def of(*args, sigfig: 2)
      @after  = :of
      @args   = args.map(&:to_f)
      @sigfig = sigfig
      self
    end

    def to_s
      if @percent
        "#{phrase} #{percent_value}%"
      else
        "#{phrase} #{value}"
      end
    end

    def percent
      @percent = true
      self
    end

    private

    def phrase
      "#{article} #{subject} #{after}".strip
    end

    def article
      if @before
        indefinitize(subject)
      end
    end

    def subject # increase, decrease, or change
      word = if @subject.to_s == 'change'
        word = 'change'
      else
        increase_or_decrease
      end
      if @tense.to_s == 'past'
        word << 'd'
      else
        word
      end
    end

    def after
      @after
    end

    def indefinitize(subject)
      if subject.match /increase/
        'an'
      elsif subject.match /decrease|change/
        'a'
      end
    end

    def increase_or_decrease
      if @args.count == 2
        @args.last > @args.first ? 'increase' : 'decrease'
      else
        @args.first > 0 ?          'increase' : 'decrease'
      end
    end

    def value
      apply_filters(@subject.to_s == 'change' ? difference : difference.abs)
    end

    def percent_value
      apply_filters(@subject.to_s == 'change' ? percent_change : percent_difference.abs)
    end

    def percent_difference
      if @args.count == 2
        (difference / @args.first).to_f * 100
      else
        @args.first
      end
    end

    def percent_change
      if @args.count == 2
        if @args.last > @args.first
          (@args.last / @args.first).to_f * 100
        else
          ((@args.first - @args.last) / @args.last).to_f * -100
        end
      else
        @args.first
      end
    end

    def difference
      if @args.count == 2
        (@args.last - @args.first)
      else
        @args.first
      end
    end

    def apply_filters(number)
      if Crease.configuration.integer
        number.to_i
      else
        number.round(@sigfig || Crease.configuration.digits)
      end
    end

  end
end
