module Mhq
  class Base < Thor::Shell::Basic
    include Hirb::Console
    include Mhq::Helpers
  end
end