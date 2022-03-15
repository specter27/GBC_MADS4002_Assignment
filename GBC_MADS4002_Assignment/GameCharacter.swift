//
//  GameCharacter.swift
//  assignment
//
//  Created by Harshit Malhotra on 2022-03-01.
//

import Foundation
class GameCharcter {
    
    // -stored properties
    let name:String
    private var healthPoints: Int
    let characterRole: String
    // -set this to 1 if the Game Character WINS
    var winner: Int
    // - computed properties (always var, never let)
    var maxHealthPoints:Int {
        get{
            return healthPoints
        }
        set(updatedHealthPoints){
            self.healthPoints = updatedHealthPoints
        }
    }
    
    // Default intializier
    /**
     Initialization is the process of preparing an instance of a class,
     Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties can’t be left in an indeterminate state
     */
    init(name:String, characterRole: String){
        self.name = name
        self.healthPoints = Int.random(in: 90...100)
        self.characterRole = characterRole
        // -By default no character wins
        self.winner = 0
    }
    
    // Methods
    
    // -takeDamage (:amt) → reduces the character’s healthpoints by the specified amount
    func takeDamage(amt: Int){
        self.healthPoints = self.healthPoints-amt
    }
    /**
     -attack() -> Int: returns an Integer containing the amount of damage dealt by the character.
     **/
//    func attack() -> Int{
//        
//    }
}
// -providing a custom respresentation of the instance to string
// equivalent of toString() in Java
extension GameCharcter: CustomStringConvertible {
    var description: String {
        get {
            return self.name.uppercased()
        }
    }
}

