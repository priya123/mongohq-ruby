module Mhq
  module Helpers

    def human_size(integer)
      if integer.to_f > 1024 * 1024 * 1024
        "#{(integer.to_f / 1024 / 1024 / 1024).round(1)}g"
      elsif integer.to_f > 1024 * 1024
        "#{(integer.to_f / 1024 / 1024).round(0)}m"
      elsif integer.to_f > 1024
        "#{(integer.to_f / 1024).round(0)}k"
      else
        "#{integer.to_i}b"
      end
    end

  end
end

if RUBY_VERSION < '1.9'
  class Float
    def round(digits)
      sprintf("%.#{digits}f", self).to_f
    end
  end
end