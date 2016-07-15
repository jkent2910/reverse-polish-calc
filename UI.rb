class UI
  attr_accessor :input, :output

  def initialize
    self.input = $stdin
    self.output = $stdout
  end

  def give(output_message)
    output.puts output_message
  end

  def receive
    @user_input = input.gets.chomp
  end
end