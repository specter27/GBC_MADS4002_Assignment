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
    
    // - computed properties (always var, never let)
    var isAttackCriticalMiss: Bool{
        get{
            var criticalMiss: Bool = false
            /**
              #Requirement
               - There is a 20% chance that the monster’s attack will miss
                 that's why 1...5 .
             */
            if(Int.random(in: 1...5) == 3){
                criticalMiss = true
            }
            return criticalMiss
        }

    }
    
    // -Default intializier
    init(name: String) {
        
        // #1. intialize the child class unique properties
        self.attackPower = Int.random(in: 10...30)
        
        // #2. call parent intializer
        super.init(name: name, characterRole: "MONSTER")
    }
}
