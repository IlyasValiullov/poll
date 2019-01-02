module Bob
  class Frank
    def say
      puts 'Hello, I am frank'
    end
  end
end


module Bob
  class Frank
    attr_reader :format

    def initialize(format="GGG")
      @format = format
    end

    def say
      puts "Hello, I am Alissa #{format}"
    end
  end
end


Bob::Frank.new.say

