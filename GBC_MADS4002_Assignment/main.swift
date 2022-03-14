//
//  main.swift
//  assignment
//
//  Created by Harshit Malhotra on 2022-03-01.


let game = SearchForLove()
// -Generating the World Map
let origin = game.generateWorldMap()
// -Placing Astrid on the Map
game.placeAstrid(mapOrigin: origin)
// -Displaying the Game Description
game.description()

// -Check for game status
var gameEnds: Bool = false
while(!gameEnds){
    // -Displaying the Game's Main Menu
    mainMenu()
}
print("---------------Search For Love Game Ends---------------- \n")

func mainMenu(){
    // -Displaying the Game options
    game.options()
    // -Reading the user input
    var userInput = readLine()
    // -Compeling user to provide valid input as per the game options
    while(!game.validateInput(userInput: userInput)){
        game.options()
        userInput = readLine()
    }
    
    // -Performing different game operations as per user Input
    switch(Int(userInput!)!){
    case 1:
        pathToAstrid = game.searchAstrid(mapOrigin: origin)
    case 2:
        game.rescueAstrid(pathToAstrid: pathToAstrid)
    case 3:
        // -The game ends
        gameEnds = true
        print("Bye!")
    default:
        print("Bye!")
    }
}
