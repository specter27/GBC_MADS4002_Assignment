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
    private var storedAbilityToAttack:Bool
    private var storedAbilityToDamage:Bool
    // - computed properties (always var, never let)
    var maxHealthPoints:Int {
        get{
            return Int.random(in: 10...100)
        }
    }
    
    var abilityToAttack:Bool{
        get{
            return storedAbilityToAttack
        }
        set(updatedAbilityToAttack){
            storedAbilityToAttack = updatedAbilityToAttack
        }
        
    }
    var abilityToDamage:Bool{
        get{
            return storedAbilityToDamage
        }
        set(updatedAbilityToDamage){
            storedAbilityToDamage = updatedAbilityToDamage
        }
    }
    
    // Default intializier
    init(name:String,abilityToAttack storedAbilityToAttack:Bool,abilityToDamage storedAbilityToDamage:Bool){
        self.name = name
        self.storedAbilityToAttack = storedAbilityToAttack
        self.storedAbilityToDamage = storedAbilityToDamage
    }
}

