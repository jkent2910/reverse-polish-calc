class UI
  attr_accessor :input, :output

  def initialize
    self.input = $stdin
    self.output = $stdout
  end

  def give(output_message, output: @output)
    output.puts output_message
  end

  def receive(input: @input)
    @user_input = input.gets.chomp
  end

  def give_welcome_message
    give("Welcome to Julie's Reverse Polish Calculator!  Type 'c' to continue or 'q' to exit.")
  end

  def give_operator_message
    give("Please enter a number with no more than 5 digits or an operator (+ - / or *).  Press 'q' to exit.")
  end

end