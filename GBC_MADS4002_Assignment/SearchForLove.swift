//
//  Generator.swift
//  GBC_MADS4002_Assignment
//
//  Created by Harshit Malhotra on 2022-03-09.
//

class SearchForLove {
    
    private let worldLocations: [String]
    private let monsterNames: [String]
    // - a. Making the worldLocations copy to generateWorldMap with *UNIQUE* Location
    var copyofWorldLocations: [String]
    
    // - b. Making the monsterNames copy to generateWorldMap with *UNIQUE* Monsters
    var copyofMonsterNames: [String]
    

    init(){
        self.worldLocations = ["Jefferson", "Santa Ana", "Wilmington", "Waco", "Oakland", "Olympia", "Medford", "Jacksonville", "Rockford", "Palmdale", "Elizabeth", "Baltimore", "Cathedral City", "Panama City", "McHenry", "Murfreesboro", "Fitchburg", "Palm Bay", "Garden Grove", "Colorado Springs", "Bremerton"]
        
        self.monsterNames = ["Bogeyman", "Vampire", "Dybbuk", "Banshee", "Pontianak", "Zombie", "Frostbite", "Hydra", "Dragon", "Griffin", "Werewolf", "Minotaur", "Mermaid", "Sandman", "Wampus cat", "Valcore"]
        copyofWorldLocations = worldLocations
        copyofMonsterNames = monsterNames
        
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
        let generatedMonster  = Monsters(name: copyofMonsterNames[randomMonsterIndex], abilityToAttack: Bool.random(), abilityToDamage: Bool.random())
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
        let randomLocationIndex = Int.random(in: 1...10)
        var currentMapNode: Map = mapOrigin
        
        while(currentMapNode.nextMapNode != nil){
            if(count == randomLocationIndex){
                // putting astrid at random location
                currentMapNode.currentLocation.astridIsHere = true
                // description variable will be called
                print("Astrid is placed at: \(currentMapNode.currentLocation)")
                break
            }else{
                count += count
                currentMapNode = currentMapNode.nextMapNode!
            }
        }
        
        
    }
    
    // -This function will display the game descrition & story to the user
    func description() {
        print("---------------Welcome to Search For Love Game---------------- \n #ABOUT GAME: \n Hugie  and Astrid are in love, and plan on getting married.\n The day before the wedding, an evil wizard kidnaps Astrid\n and takes Astrid to a castle somewhere in the world.\n Hugie is distraught and determined to save Astrid\n You Are Hero Named: Hugie")
    }
    
    // -This function will display the available game options to the user
    func options() {
        print("1. Search for Astrid \n2. Rescue Astrid \n3. Quit \nEnter choice: ")
    }
    // -This function will validate the userInput and return as per result.
    func validateInput(userInput: String?) -> Bool{
        var validationResult: Bool = false
        var validInput: Int = Int.min
        if(userInput == nil ){
            validationResult = false
            print("Invalid selection, try again.")
        }else{
            let inputValue = Int(userInput!) ?? -1
            if(inputValue == 1 || inputValue == 2 || inputValue == 3){
                validationResult = false
                validInput = inputValue
            }else{
                print("Invalid selection, try again.")
            }
        }
        print("\(validInput)")
        return validationResult
    }

}
