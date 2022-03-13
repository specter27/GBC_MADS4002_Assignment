//
//  Road.swift
//  GBC_MADS4002_Assignment
//
//  Created by Samarth Joshi on 2022-03-04.
//

class Road {
    // -Stored Properties
    private let startingLocation:Location
    private let endingLocation:Location?
    private let typeofRoad: RoadType
    
    // -computed Properties
    // - getRandomRoadType will be used while generating maps
    static var getRandomRoadType: RoadType{
        get{
            /**
             Initializing from a Raw Value
             
             If you define an enumeration with a raw-value type, the enumeration automatically receives an initializer that takes a value of the raw value’s type (as a parameter called rawValue) and returns either an enumeration case or nil.
             */
            return RoadType(rawValue: Int.random(in: 1...3))!
        }
    }
    
    
    // Default Intializer
    /**
     Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.
     */
    init(startingLocation:Location, typeofRoad: RoadType)
    {
        self.startingLocation = startingLocation
        self.typeofRoad = typeofRoad
        // setting the End Location nil intially
        self.endingLocation = nil
    }
    
}

// -providing a custom respresentation of the instance to string
// equivalent of toString() in Java
extension Road: CustomStringConvertible {
    var description: String {
        get {
            return "Starting Location: \(self.startingLocation) \n Type of Road: \(self.typeofRoad) \n End Location: \(String(describing: self.endingLocation)) \n"
        }
    }
}

