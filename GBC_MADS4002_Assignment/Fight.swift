//
//  Fight.swift
//  GBC_MADS4002_Assignment
//
//  Created by Harshit Malhotra on 2022-03-02.
//

import Foundation
class Fight{
    // -stored properties
    private var hero:Heros
    private var monster:Monsters
    private var storedFightStatus: Bool
    private var storedTurn: GameCharcter
    // - computed properties (always var, never let)
    var isFightOver: Bool{
        get{
            return storedFightStatus
        }
        set(updatedFightStatus){
            storedFightStatus = updatedFightStatus
        }

    }
    // - for tracking which character has the turn
    var characterTurn: GameCharcter{
        get{
            return storedTurn
        }
        set(updatedTurn){
            storedTurn = updatedTurn
        }
    }
    
    /**
     If you don’t want to use an argument label for an initializer parameter, write an underscore ( _ ) instead of an explicit argument label for that parameter to override the default behavior.
     */
    init(_ hero:Heros, _ monster:Monsters,
         fightStatus storedFightStatus:Bool,gameCharacterTurn storedTurn:GameCharcter ) {
        self.hero = hero
        self.monster = monster
        self.storedFightStatus = storedFightStatus
        self.storedTurn = storedTurn
    }
    func applyDamage(_ from:String ,_ to:String) {
       
    }
    func performTurn(_ action:String){
        
    }
    
    func checkHero() -> Heros {
        return self.hero
    }
    func checkMonster() -> Monsters {
        return self.monster
    }

}
