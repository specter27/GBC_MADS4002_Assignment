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
  
    var pathToAstrid:[Location]?=[];
  
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
    

    
    func findAstrid(mapOrigin:Map)->[Location]?
        {
            if(mapOrigin.nextMapNode==nil)
            {
                print("searching \(mapOrigin.currentLocation)",terminator: "");
                if(isAstridHere(currentLocation: mapOrigin.currentLocation))
                {
                    print("Astrid found at \(mapOrigin.currentLocation)")
                    pathToAstrid?.append(mapOrigin.currentLocation)
                    print("astrid at final \(pathToAstrid!)")
                    return pathToAstrid;
                }
                else
                {
                    print("Astrid is not on the map \n");
                }
            }
            else
            {
                print("searching \(mapOrigin.currentLocation)",terminator: "");
                if(isAstridHere(currentLocation: mapOrigin.currentLocation))
                {
                    pathToAstrid?.append(mapOrigin.currentLocation)
                    print("Astrid found at \(mapOrigin.currentLocation)")
                    print(pathToAstrid!)
                    return pathToAstrid
                }
                else
                {
                    for i in getRoadsGoingOut(startLocationDetails: mapOrigin.currentLocation)
                    {
                        if(i.typeofRoad==RoadType.PAVED)
                        {
                            print("type of road is \(i.typeofRoad)")
                            pathToAstrid?.append(mapOrigin.currentLocation)
                            print("Astrid not found, moving to next city");
                            break;
                        }
                        else if(i.typeofRoad==RoadType.SWAMP)
                        {
                            print("type of road is \(i.typeofRoad)")
                            pathToAstrid?.append(mapOrigin.currentLocation)
                            print("Astrid not found, moving to next city");
                            break;
                        }
                        else if(i.typeofRoad==RoadType.MOUNTAIN)
                        {
                            print("type of road is \(i.typeofRoad)")
                            pathToAstrid?.append(mapOrigin.currentLocation)
                            print("Astrid not found, moving to next city");
                            break;
                        }
                    }
                    //pathToAstrid?.append(mapOrigin.currentLocation)
                    //print("Astrid not found, moving to next city");
                }
                findAstrid(mapOrigin: mapOrigin.nextMapNode!);
            }
            return nil
        }
        
        func isAstridHere(currentLocation:Location)->Bool
        {
            if(currentLocation.astridIsHere==true)
            {
                return true
            }
            return false;
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
    func placeAstrid(mapOrigin: Map){
        var count = 1
        let randomLocationIndex = Int.random(in: 1...15)
        var currentMapNode: Map = mapOrigin
      
        while(currentMapNode.nextMapNode != nil){
            if(count == randomLocationIndex){
                // putting astrid at random location
                currentMapNode.currentLocation.astridIsHere = true
                // description variable will be called
                print("Astrid is placed at: \(currentMapNode.currentLocation)")
                break
            }else{
                count += 1
                currentMapNode = currentMapNode.nextMapNode!
            }
        }
        
        
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
            print("Invalid selection, try again.")
        }else{
            let inputValue = Int(userInput!) ?? -1
            if(inputValue == 1 || inputValue == 2 || inputValue == 3){
                validationResult = true
            }else{
                print("Invalid selection, try again.")
            }
        }
        return validationResult
    }
    
//    func searchAstrid(mapOrigin:Map) -> [Location]{
        
        // if the astrid is not on the map then don't update the searchCompletionStatus to TRUE Otherwise do update the searchCompletionStatus to TRUE
        
        
//        if(mapOrigin.nextMapNode==nil) {
//            print("searching \(mapOrigin.currentLocation)",terminator: "");
//            if(isAstridHere(currentLocation: mapOrigin.currentLocation)) {
//                print("Astrid found")
//            } else {
//                print("Astrid is not on the map \n");
//            }
//        } else {
//                print("searching \(mapOrigin.currentLocation)",terminator: "");
//                if(isAstridHere(currentLocation: mapOrigin.currentLocation))
//                {
//                    print("Astrid found")
//                }
//                else
//                {
//                    print("Astrid not found, moving to next city");
//                }
//                traverseMap(mapOrigin: mapOrigin.nextMapNode!);
//            }
//        }
    
    
    // -This function will execute the Rescue Sequence
    func rescueAstrid(pathToAstrid: [Location]){
        
        // checking if the astrid is on the map and is being searched by the user
        if(searchCompletionStatus && pathToAstrid.count == 0){
            print("Astrid is Not on the Map")
        }else if(!searchCompletionStatus && pathToAstrid.count == 0){
            print("First, Search For Astrid")
        } else if(searchCompletionStatus && pathToAstrid.count>0){
            
            // # Check if the Astrid is already being rescued or not??
            // code here
            // 1. Generate and display the easiest path to Astrid
            print("Starting quest\n  Generating the easiest path to Astrid....\n  Path found. The easiest path to Astrid is: \(pathToAstrid)")
            
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
                        
                        // -checking if the fight is over or not
                        if(fight.isFightOver){
                            print("Fight is over\nFinal stats:\n")
                            print("\(hero) HP: \(heroCurrentHealthPoints)/\(heroIntialHealthPoints)")
                            print("\(currentLocation.monster) HP: \(monsterCurrentHealthPoints)/\(monsterIntialHealthPoints)")
                            // -Checking & Displaying the winner
                            print("Winner is: \(hero.winner == 1 ? hero : currentLocation.monster)")
                            // -Displaying Final Message
                            print("\(hero.winner == 1 ? "You rescued Astrid! Congratulations!\n\n" : "You are unable to rescue Astrid!\n\n")")
                            break
                        }
                        
                        // increment turn count
                        turnCount += 1
                        // -Switching Turns for the Game Character
                        if(fight.characterTurn.characterRole == "HERO"){
                            fight.characterTurn = currentLocation.monster
                        } else{
                            fight.characterTurn = hero
                        }
                        
                    }
                }
                // -while loop ends
                if(fight.isFightOver){
                    
                    // -Update the rescueCompletionStatus as the rescue completed
//                    self.rescueCompletionStatus = true
                    break
                }
                
                
            } // -for loop ends
        } // -else if statement ends
    }
    
    func startFightOverSequence(_ fight: Fight){
        
        
    }
    
    func getHeroMoves(){
        print("Hugie, what move will you make?\n   1. Attack\n   2. Sneak\n   3. Give Up\nEnter choice: ")
    }


}
