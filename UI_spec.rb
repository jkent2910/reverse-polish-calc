require './ui'
require 'rspec'

describe "UI" do
  before(:each) do
    @ui = UI.new
    @input = StringIO.new("hello world")
    @output = StringIO.new
    @user_input = @ui.receive(input: @input)
    @ui.give("hello Julie", output: @output)
  end

  it "should output a message for the user" do
    expect(@output.string).to eq("hello Julie\n")
  end

  it "should return the user's input" do
    expect(@user_input).to eq("hello world")
  end
end