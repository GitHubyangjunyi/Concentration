//
//  Card.swift
//  Concentration
//
//  Created by 杨俊艺 on 2019/9/26.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation
 
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
