//
//  Heroes.swift
//  GBC_MADS4002_Assignment
//
//  Created by Harshit Malhotra on 2022-03-02.


enum heroActions: Int {
    // - Implicit Assignment of Raw Values
    case attack = 1,sneak,run_away
}

import Foundation
class Heros : GameCharcter{
    
    // --stored properties
    var weaponStrength: Int
    
    // - computed properties (always var, never let)
    var isAttackCriticalHit: Bool{
        get{
            var criticalHit: Bool = false
            /**
              #Requirement
               - Hugie has a 30% chance of performing a critical hit
                 that's why 1...3 .
             */
            if(Int.random(in: 1...3) == 1){
                criticalHit = true
                
            }
            return criticalHit
        }

    }
    // This will tell will the hero be able to sneak or Not.
    var canHeroSneak: Bool{
        get{
            var sneakStatus: Bool = false
            /**
              #Requirement
               - Hugie has a 30% chance of successfully sneaking away
                that's why 1...3 .
             */
            if(Int.random(in: 1...3) == 2){
                sneakStatus = true
            }
            return sneakStatus
        }
    }
        
    // -Default intializier
    init(name: String) {
        
        // #1. intialize the child class unique properties
        self.weaponStrength = Int.random(in: 10...30)
        
        // #2. call parent intializer
        super.init(name: name, characterRole: "HERO")
    }
    
    // -Methods
    // -Displaying the sneak action results
    func printSneakResult(monster: Monsters) -> Bool {
        let re = canHeroSneak
        if(re){
            print("*** \(name) is sneaking\n*** \(name) successfully sneaked past \(monster)\n\n")
            /**
             #Requirement
             if Hugie successfully sneaks away,
             Hugie automatically wins the fight.
             Hero Wins
             **/
            winner = 1
        }else{
            print("*** \(name) is sneaking\n*** \(name) was un-successfully sneaking past \(monster)\n\n")
            // -Monster Wins
            monster.winner = 1
        }
        return re
    }
    
    // -This function will RESET the hero's health
    func resetHealth(){
        self.maxHealthPoints = 95
    }

}

