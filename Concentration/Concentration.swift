//
//  Concentration.swift
//  Concentration
//
//  Created by 杨俊艺 on 2019/9/26.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {                                           //待匹配卡牌占位符(使用计算属性抽离chooseCard的逻辑)
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil                                                  //发现两张卡牌朝上则是未匹配设置为进入下一轮
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)                         //除了待匹配的牌全部将其盖上重新进入下一轮
            }
        }
    }
    
    // MARK: 更新卡牌的状态信息,视图控制器稍后根据这些信息更新视图View
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
        if !cards[index].isMatched {                                                //如果被点击按钮所对应的卡牌未匹配则执行下边规则,如果卡牌是已经匹配过的不做任何动作直接返回
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {      //令matchIndex等于待匹配卡牌且当前被点击按钮不是重复点击,也就是翻开一张卡牌后必须选择另一张卡牌进行匹配
                if cards[matchIndex].identifier == cards[index].identifier {                //如果待匹配卡牌身份等于当前翻开的卡牌身份
                    cards[matchIndex].isMatched = true                                          //两张卡牌都将进入匹配状态
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true                                                    //将当前卡牌朝上
            } else {                                                                         //将当前卡牌朝上(游戏刚开始☝️第一次点击跳转位置)
                indexOfOneAndOnlyFaceUpCard = index                                         //将待匹配卡牌标记为当前翻开的卡牌并将除了待匹配的卡牌之外的所有卡牌盖上重新进入下一轮
            }
        }
    }
    
    // MARK: 使用卡牌对数进行游戏初始化
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must hava at least one pair of cards")
        for _ in 0 ..< numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]                                                   //生成两张一模一样的卡牌放入游戏自带的数组中
        }
        shuffleCards()
        for card in cards {
            print("\(card.identifier)")
        }
    }
    
    // TODO: 洗牌
    mutating func shuffleCards() {
        cards = cards.shuffled()
    }
}
