module Crease
  class Builder

    def criteria
      @criteria ||= {}
    end

    def initialize(context: nil, tense: :present)
      criteria.merge!({ context: context, tense: tense })
      self
    end

    def increase
      criteria.merge!({ tense: :present })
      self
    end

    alias_method :decrease, :increase

    def by(*args, sigfig: 2)
      criteria.merge!({ word: :by })
      criteria.merge!({ args: args.map(&:to_f) })
      criteria.merge!({ sigfig: sigfig })
      self
    end

    def of(*args, sigfig: 2)
      criteria.merge!({ word: :of })
      criteria.merge!({ args: args.map(&:to_f) })
      criteria.merge!({ sigfig: sigfig })
      self
    end

    def to_s
      if criteria[:percent]
        "#{base_string} #{percent_change}%"
      else
        "#{base_string} #{value}"
      end
    end

    def percent
      criteria.merge!({ percent: true })
      self
    end

    def base_string
      past = criteria[:tense] == :past ? 'd' : ''
      str = "#{article}#{increase_or_decrease}#{past}"
      str << " #{criteria[:word]}" if criteria[:word]
      str
    end

    private

    def article
      return unless criteria[:context]
      # Could use ActiveSupport #indefinitize
      if increase_or_decrease == :increase
        'an '
      elsif increase_or_decrease == :decrease
        'a '
      end
    end

    def increase_or_decrease
      args = criteria[:args]
      if args.count == 2
        args.last > args.first ? :increase : :decrease
      else
        args.first > 0 ? :increase : :decrease
      end
    end

    def value
      base_calculation.round(criteria[:sigfig])
    end

    def percent_change
      args = criteria[:args]
      if args.count == 2
        if args.last > args.first
          base_calculation
        else
          base_calculation.abs / args.first
        end * 100.to_f
      else
        base_calculation
      end.round(criteria[:sigfig])
    end

    def base_calculation
      args = criteria[:args]
      if args.count == 2
        (args.last - args.first).abs
      else
        args.first.abs
      end
    end

  end
end
