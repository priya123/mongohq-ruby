module Mhq
  module Helpers

    def human_size(integer)
      if integer.to_f > 1024 * 1024 * 1024
        "#{(integer.to_f / 1024 / 1024 / 1024).round(2)}g"
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