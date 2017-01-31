unless 42.respond_to? :positive?
  class Numeric
    def positive?
      self > 0
    end
  end
end
