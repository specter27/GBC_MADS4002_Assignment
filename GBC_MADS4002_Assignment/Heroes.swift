//
//  Heroes.swift
//  GBC_MADS4002_Assignment
//
//  Created by Harshit Malhotra on 2022-03-02.
//

import Foundation
class Heros : GameCharcter{
    var weaponStrength:Int = 0
    var abilityToSneak:Bool = false
    
    enum actions: CaseIterable {
        case attack,sneak,run_away
    }

}
