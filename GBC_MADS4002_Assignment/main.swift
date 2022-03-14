//
//  main.swift
//  assignment
//
//  Created by Harshit Malhotra on 2022-03-01.
/**
 Initialization is the process of preparing an instance of a class,
 Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state
 */
let game = SearchForLove()
// -Generating the World Map
let origin = game.generateWorldMap()
// -Placing Astrid on the Map
game.placeAstrid(mapOrigin: origin)
// -Displaying the Game Description
game.description()
// -Displaying the Game options
game.options()
// -Reading the user input
var userInput = readLine()
// -Compeling user to provide valid input as per the game options
while(!game.validateInput(userInput: userInput, mapOrigin: origin)){
    game.options()
    userInput = readLine()
}


print("Map Details:\n \(origin)")


