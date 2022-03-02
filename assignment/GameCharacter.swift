//
//  GameCharacter.swift
//  assignment
//
//  Created by Harshit Malhotra on 2022-03-01.
//

import Foundation
class GameCharcter {
    var count = 0
    func increment() -> Int{
        count += 1
        return count
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

