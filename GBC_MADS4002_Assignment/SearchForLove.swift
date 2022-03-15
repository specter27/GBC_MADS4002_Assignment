//
//  Generator.swift
//  GBC_MADS4002_Assignment
//
//  Created by Harshit Malhotra on 2022-03-09.
//

class SearchForLove {
    
    private let worldLocations: [String]
    private let monsterNames: [String]
    // -To moniter the status for the search & rescue option
    private var searchCompletionStatus: Bool
    private var rescueCompletionStatus: Bool
    // -hero of the game
    private var hero: Heros
  
    // - a. Making the worldLocations copy to generateWorldMap with *UNIQUE* Location
    var copyofWorldLocations: [String]
    
    // - b. Making the monsterNames copy to generateWorldMap with *UNIQUE* Monsters
    var copyofMonsterNames: [String]
    

    init(){
        self.worldLocations = ["Jefferson", "Santa Ana", "Wilmington", "Waco", "Oakland", "Olympia", "Medford", "Jacksonville", "Rockford", "Palmdale", "Elizabeth", "Baltimore", "Cathedral City", "Panama City", "McHenry", "Murfreesboro", "Fitchburg", "Palm Bay", "Garden Grove", "Colorado Springs", "Bremerton"]
        
        self.monsterNames = ["Bogeyman", "Vampire", "Dybbuk", "Banshee", "Pontianak", "Zombie", "Frostbite", "Hydra", "Dragon", "Griffin", "Werewolf", "Minotaur", "Mermaid", "Sandman", "Wampus cat", "Valcore"]
        self.copyofWorldLocations = worldLocations
        self.copyofMonsterNames = monsterNames
        self.searchCompletionStatus = false
        self.rescueCompletionStatus = false
        self.hero = Heros(name: "Hugie")
        
        
    }
    
    func generateWorldMap() -> Map{
//        print("count of copyofWorldLocations: \(copyofWorldLocations.count)\ncount of copyofMonsterNames: \(copyofMonsterNames.count)")
        
        print("Generating World Map......")
        
        // #1. Generating random Index for getting Location & Monster
        let randomMonsterIndex = Int.random(in: 0...copyofMonsterNames.count-1)
        let randomLocationIndex = Int.random(in: 0...copyofWorldLocations.count-1)
        
        // generating the first map node which will act as the root OR orgin of the map
        let mapOrigin = getMapNode(randomLocationIndex: randomLocationIndex,
                                   randomMonsterIndex: randomMonsterIndex)
        
        // #2. Removing the used Monsters & Location from the List (To Keep Locations & Monsters UNIQUE)
        copyofMonsterNames.remove(at: randomMonsterIndex)
        copyofWorldLocations.remove(at: randomLocationIndex)
        
//        print("count of copyofWorldLocations: \(copyofWorldLocations.count)\ncount of copyofMonsterNames: \(copyofMonsterNames.count)")
        
        // Creating a Random World Map with 10 different Locations OR Map Node
        for _ in 0...9{

            // #1. Generating random Index for getting Location & Monster
            let randomMonsterIndex = Int.random(in: 0...copyofMonsterNames.count-1)
            let randomLocationIndex = Int.random(in: 0...copyofWorldLocations.count-1)

            insertMapNode(currentLocationNode: mapOrigin,
                          nextLocationNode: getMapNode(
                           randomLocationIndex: randomLocationIndex,
                           randomMonsterIndex: randomMonsterIndex)
                          )

            // #2. Removing the used Monsters & Location from the List (To Keep Locations & Monsters UNIQUE)
            copyofMonsterNames.remove(at: randomMonsterIndex)
            copyofWorldLocations.remove(at: randomLocationIndex)
        }
        print("World Map Generated!!")
        return mapOrigin;
        
    }
    // - This function will insert a new Location Node in our World Map
    func insertMapNode(currentLocationNode: Map, nextLocationNode: Map) {
       
        if(currentLocationNode.nextMapNode == nil){
            currentLocationNode.nextMapNode = nextLocationNode
        }else{
            insertMapNode(currentLocationNode: currentLocationNode.nextMapNode!,
                          nextLocationNode: nextLocationNode)
        }
        
    }
    
    // -This function will give a random Map Node for the World Map
    func getMapNode(randomLocationIndex: Int, randomMonsterIndex: Int) -> Map{
        
        // #1. Creating Monster & Location objects

        let generatedMonster  = Monsters(name: copyofMonsterNames[randomMonsterIndex])

        let generatedLocation = Location(locationName: copyofWorldLocations[randomLocationIndex], monster: generatedMonster)
        
        // #2. Generating Map Node with the generatedLocation
        let generatedMapNode = Map(currentLocation: generatedLocation, roadsLeadingOut: getRoadsGoingOut(startLocationDetails: generatedLocation))
        
        return generatedMapNode
        
    }
    
    // -This function will generate the [Road] OR Road Array Leading out for a MapNode
    func getRoadsGoingOut(startLocationDetails: Location) -> [Road]{
        /**
         #Requirement
         As each location, there could be zero or more roads connecting the location to another
         location on the map.
         **/
        let totalRoads = Int.random(in: 0...3)
        var roadsToNextNode: [Road] = []
        for _ in 0...totalRoads {
            let road = Road(startingLocation: startLocationDetails,typeofRoad: Road.getRandomRoadType)
            roadsToNextNode.append(road)
        }
        return roadsToNextNode
    }
    // This function will place astrid at a random Location on the World Map
    func placeAstrid(mapOrigin: Map) -> Bool{
        var count = 1
        // -stores weather the astrid is being placed on the map or not
        var astridPlaced: Bool = false
        let randomLocationIndex = Int.random(in: 1...15)
        var currentMapNode: Map = mapOrigin
      
        while(currentMapNode.nextMapNode != nil){
            if(count == randomLocationIndex){
                // putting astrid at random location
                currentMapNode.currentLocation.astridIsHere = true
                // -As astrid is being successfully placed
                astridPlaced = true
                // description variable will be called
                print("Astrid is placed at: \(currentMapNode.currentLocation)")
                break
            }else{
                count += 1
                currentMapNode = currentMapNode.nextMapNode!
            }
        }
        return astridPlaced
    }
    
    // -This function will display the game descrition & story to the user
    func description() {
        print("---------------Welcome to Search For Love Game---------------- \n #ABOUT GAME: \nHugie  and Astrid are in love, and plan on getting married.\nThe day before the wedding, an evil wizard kidnaps Astrid\nand takes Astrid to a castle somewhere in the world.\nHugie is distraught and determined to save Astrid\n\nYou Are Hero Named: Hugie \n")
    }
    
    // -This function will display the available game options to the user
    func options() {
        print("Hugie, what will you do?\n1. Search for Astrid \(self.searchCompletionStatus ? "[COMPLETE!]" : "")\n2. Rescue Astrid \(self.rescueCompletionStatus ? "[COMPLETE!]" : "")\n3. Quit \nEnter choice: ")
    }
    // -This function will validate the userInput and return as per result.
    func validateInput(userInput: String?) -> Bool{
        var validationResult: Bool = false
        if(userInput == nil ){
            print("Invalid selection, try again.\n")
        }else{
            let inputValue = Int(userInput!) ?? -1
            if(inputValue == 1 || inputValue == 2 || inputValue == 3){
                validationResult = true
            }else{
                print("Invalid selection, try again.\n")
            }
        }
        return validationResult
    }
    
    /**This Method will Search astrid on the World Map and Return a Location Array for th epath leading to astrid if that exist**/
    
    func searchAstrid(mapOrigin: Map, astridPlacementStatus: Bool) -> [Location]{
    
        var currentMapNode = mapOrigin
        var hasNextNode: Bool = true
        var pathToAstrid:[Location] = []
        // -checking weather the astrid is on the map or not
        if(astridPlacementStatus){
            print("Starting the search for Astrid")
            while(hasNextNode){
                // -Adding the location in the pathToAstrid
                pathToAstrid.append(currentMapNode.currentLocation)
                // -Displaying the Location details while Traversing
                print("   Searching \(currentMapNode.currentLocation): \(currentMapNode.currentLocation.astridIsHere ? " Astrid found!\n\n": " Astrid not found, moving to next city")")
                
                // #1. Checking weather astrid is at the Location or Not
                if(currentMapNode.currentLocation.astridIsHere){
                    print("\n\nAstrid is in \(currentMapNode.currentLocation)\n\n---------------------------------------\n")
                    break
                }
                // #2. Checking the existence of the easiest road (RAREST CASE)
                if(currentMapNode.roadsLeadingOut.count == 0){
                    print("No Roads Leading out of the \(currentMapNode.currentLocation)")
                    break
                }
                // -updating the current node
                if(currentMapNode.nextMapNode != nil){
                    currentMapNode = currentMapNode.nextMapNode!
                }else{
                    hasNextNode = false
                }
            }
        }else{
            traverseWorldMap(mapOrigin: mapOrigin)
            print("Astrid is not on the map \n\n\n---------------------------------------\n");
        }
        // -Updating the searchCompletionStatus to TRUE as search is completed
        self.searchCompletionStatus = true
        return pathToAstrid
    }
    
    // -This Function will simply Traverse the World Map & Display the Location details while Traversing
    func traverseWorldMap(mapOrigin: Map){
        var currentMapNode = mapOrigin
        print("Starting the search for Astrid")
        while(currentMapNode.nextMapNode != nil){
            print("   Searching \(currentMapNode.currentLocation): Astrid not found, moving to next city")
            currentMapNode = currentMapNode.nextMapNode!
        }
        // -Displaying the last or terminus Map Node Location Details
        print("   Searching \(currentMapNode.currentLocation): Astrid not found, moving to next city")
    }
    
    
    
    // -This function will execute the Rescue Sequence
    func rescueAstrid(pathToAstrid: [Location]){
        // checking if the astrid is on the map and is being searched by the user
        if(searchCompletionStatus && pathToAstrid.count == 0){
            print("Astrid is Not on the Map")
        }else if(!searchCompletionStatus && pathToAstrid.count == 0){
            print("\n\nFirst, Search For Astrid!!\n")
        }/** - 1st else if statement ends**/ else if(searchCompletionStatus && pathToAstrid.count>0 && !rescueCompletionStatus){
            
            
            // 1. Generate and display the easiest path to Astrid
            print("Starting quest\n  Generating the easiest path to Astrid....\n  Path found. The easiest path to Astrid is: \(pathToAstrid)\n")
            
            // -Loop for executing the rescueing operation at all the locations leading to astrid
            for currentLocation in pathToAstrid {
                print("ARRIVED AT \(currentLocation.locationName.uppercased())\n\(currentLocation.monster) IS WAITING TO FIGHT!\nFIGHT BEGINS!\n")
                
                /**
                   #Requirement
                    - In this application, Hugie always goes first.
                 */
                // staring the fight for current Location
                let fight = Fight(hero, currentLocation.monster, gameCharacterTurn: hero)
                // -keeping the turn count
                var turnCount = 1
                let heroIntialHealthPoints = hero.maxHealthPoints
                let monsterIntialHealthPoints = currentLocation.monster.maxHealthPoints
                
                // -Loop for executing the Fight Sequence at each location
                while(!fight.isFightOver){
                    
                    let heroCurrentHealthPoints = hero.maxHealthPoints
                    let monsterCurrentHealthPoints = currentLocation.monster.maxHealthPoints
                   
                    
                    print("---------Turn #: \(turnCount)---------\n")
                    print("Current Turn is: \(fight.characterTurn)")
                    print("\(hero) HP: \(heroCurrentHealthPoints)/\(heroIntialHealthPoints)")
                    print("\(currentLocation.monster) HP: \(monsterCurrentHealthPoints)/\(monsterIntialHealthPoints)")
                    // -If current turn is for HERO
                    if(fight.characterTurn.characterRole == "HERO"){
                        
                        // - Displaying available Hero Moves
                        getHeroMoves()
                        // - Reading the user input
                        var userInput = readLine()
                        // -Compeling user to provide valid input as per the game options
                        while(!validateInput(userInput: userInput)){
                            getHeroMoves()
                            userInput = readLine()
                        }
                        /**
                          - used Forced Unwrapping as the userInput is already being validated
                          - performing action as per user input after unwrapping the value
                         */
                        fight.performTurn(Int(userInput!)!)
                        
                    }else{
                        // -else current turn is for MONSTER
                        /**
                          - used Forced Unwrapping as the userInput is already being validated
                          - performing action as per user input after unwrapping the value
                         */
                        // -As Monster have only one available action that is: Attack(rawValue: 1)
                        fight.performTurn(1)
                        
                    }
                    /**
                     #Task 1:
                      -checking if the fight is over or not and was astrid at the Current Location **/
                    if(fight.isFightOver){
                        print("\n\nFight is over\nFinal stats:\n")
                        print("\(hero) HP: \(hero.maxHealthPoints)/\(heroIntialHealthPoints)")
                        print("\(currentLocation.monster) HP: \(currentLocation.monster.maxHealthPoints)/\(monsterIntialHealthPoints)")
                        // -Checking & Displaying the winner
                        print("Winner is: \(hero.winner == 1 ? hero : currentLocation.monster)\n\n")
                        break
                    }
                    // #Task 2: increment turn count
                    turnCount += 1
                    // #Task 3: Switching Turns for the Game Character
                    if(fight.characterTurn.characterRole == "HERO"){
                        fight.characterTurn = currentLocation.monster
                    } else{
                        fight.characterTurn = hero
                    }
                } // -while loop ends
                /** -checking if the fight is over AND astrid is at the Current Location **/
                if(fight.isFightOver && currentLocation.astridIsHere){
                    
                    // -Displaying Final Message
                    print("\(hero.winner == 1 ? "You rescued Astrid! Congratulations!\n\n" : "You are unable to rescue Astrid!\n\n")")
                    
                    // -Update the rescueCompletionStatus as the rescue completed
                    self.rescueCompletionStatus = true
                    break
                }
                
                // -Reseting the Hero healthPoints for the Fight at next Location
                hero.resetHealth()
            } // -for loop ends
        } /** - 2nd else if statement ends**/
        // -Check if the Astrid is already being rescued or not??
        else if(searchCompletionStatus && pathToAstrid.count>0 && rescueCompletionStatus){
            if(hero.winner == 1){
                print("  Hugie already rescued Astrid!!\n\n")
            }else{
                print("  Hugie was unable to rescue Astrid!!\n\n")
            }
            
        }  /** - 3rd else if statement ends**/
    }
    
    func getHeroMoves(){
        print("Hugie, what move will you make?\n   1. Attack\n   2. Sneak\n   3. Give Up\nEnter choice: ")
    }


}
