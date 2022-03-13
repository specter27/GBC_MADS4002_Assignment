//
//  Location.swift
//  GBC_MADS4002_Assignment
//
//  Created by Samarth Joshi on 2022-03-04.
//

import Foundation
class Location {
    
    // -Stored Properties
    private let locationName:String
    private let monster:Monsters
    // - Computed properties (always var, never let)
    private var storedAstridIsHere: Bool = false
    var astridIsHere:Bool {
        get{
            return storedAstridIsHere
        }
        set(astridLocation){
            storedAstridIsHere = astridLocation
        }
        
    }
    /**
     Swift provides an automatic argument label for every parameter in an initializer if you don’t provide one.
     */
    init(locationName:String,monster:Monsters)
    {
        self.locationName=locationName;
        self.monster=monster;
    }
    
}
// -providing a custom respresentation of the instance to string
// equivalent of toString() in Java
extension Location: CustomStringConvertible {
    var description: String {
        get {
            return "Location Name: \(self.locationName) \n"
        }
    }
}

