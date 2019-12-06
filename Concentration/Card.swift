//
//  Card.swift
//  Concentration
//
//  Created by 杨俊艺 on 2019/9/26.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation
 
struct Card: Hashable {
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int{
        identifierFactory += 1
        return Card.identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
