## The Odin Project - Ruby Programming 
### Project: Mastermind

(Work in Progress)

Built a version of [Mastermind](https://en.wikipedia.org/wiki/Mastermind_(board_game)) in Ruby that a player can play against the computer.

This project is from The Odin Project's [curriculum](https://www.theodinproject.com/courses/ruby-programming/lessons/mastermind).

## Game Description
Welcome to Mastermind! This is a one-player game against the computer. 

## Instructions
The Computer will generate a 4 digit Secret Code. You must guess the code within twelve guesses in order to win. 

There can be more than one of the same number.

With each guess, you will receive up to 4 clues to help you decipher the code. A red peg means that one of your guesses is both the correct number and in the correct position. A grey peg means that one of your guesses is the right number, but not in the correct position. 

## Summary 
* First designed a basic version with a Computer generating the secret code, and a Player inputting guesses.  
  * Created a GamePlay class to contain game methods, a Computer class and a Player class.
  * Used the **rand** method to generate the Computer's secret code of four random numbers between 1 and 6.
  * Created a hash of six colors in a **colorize** method in a Display module to show background colors on six numbers in the terminal.
  * Used **unicode** to create colorized circles to be the pegs providing clues.
  * Wrote methods to check validity of user input
  * Employed **each_with_index** loops to check the two arrays against each other, and return feedback for clues. 


