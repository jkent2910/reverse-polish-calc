# Reverse Reverse Polish Calculator
## Description: 
This simple command line calculator will prompt a user to enter numbers (up to 5 digits) and one of four operators (+, -, *, %) to perform Reverse Polish calculations.  If you'd like to learn more about how Reverse Polish calculators work, please see the Wikipedia page: https://en.wikipedia.org/wiki/Reverse_Polish_notation. 

## To Run Interactive Version: 
Simply start an IRB session from your terminal and create a new PolishCalculator instance (for ex: p = PolishCalculator.new)
Then, call the "start_calculator" method on your PolishCalculator object (for ex: p.start_calculator)
From there follow the prompts from your terminal session.  Press 'q' to end the program at anytime.

## To View Non-Interactive Version: 
Open the Calculator.rb file and take a look!  :-P  This Calculator class creates methods for the functionality of a RPN but does not actually provide a "UI" to interact with a user.

## Tests:
To run the tests, run rspec PolishCalculator_spec.rb or rspec Calculator_spec.rb or rspec UI_spec.rb from your terminal.  

## Other notes: 
My biggest concern is that I did not do a good job of figuring out a way to abstract I/O to make the code testable.  This resulted in the majority of my tests for the Interactive PolishCalculator.rb class to stay in pending status.  My goal with writing another class with the basic methods was to provide reusable methods that could potentially be used with a Web Socket or other implementation, as well as test the underlying logic.  I would definitely research more into how to design a program to be implemented in different ways (WebSocket, TCP, file, etc.) if I were to spend additional time.  The number of lines also seems a bit much for the PolishCalculator class, so it may make sense to create other Classes as well or condense the code down.  I tried to utilize well named methods and break things into different methods which made the number of lines longer than what I'm sure could be done in about half.  Overall, this was a fun exercise as I had no idea what a Reverse Polish Calculator was (I know, crazy right?) and it gave me good practice writing plain 'ol Ruby without all of the stuff built in with Rails.  I'd also probably just tell people to use a normal calculator...  :-P 
