//
//  Monsters.swift
//  GBC_MADS4002_Assignment
//
//  Created by Harshit Malhotra on 2022-03-02.
//

import Foundation
class Monsters : GameCharcter{
    // -strored properties
    var attackPower:Int
    
    override init(name: String, abilityToAttack : Bool, abilityToDamage : Bool) {
        
        // #1. intialize the child class unique properties
        self.attackPower = Int.random(in: 10...88)
        
        // #2. call parent intializer
        super.init(name: name, abilityToAttack: abilityToAttack, abilityToDamage: abilityToDamage)
    }
}

// -providing a custom respresentation of the instance to string
// equivalent of toString() in Java
extension Monsters: CustomStringConvertible {
    var description: String {
        get {
            return "Monster Name: \(super.name) \n"
        }
    }
}
