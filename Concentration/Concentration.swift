//
//  Concentration.swift
//  Concentration
//
//  Created by 杨俊艺 on 2019/9/26.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?                                           //待匹配卡牌占位符
    
    // MARK: 更新卡牌的状态信息,视图控制器稍后根据这些信息更新视图View
    func chooseCard(at index: Int) {
        // MARK: 测试
//        if cards[index].isFaceUp {
//            cards[index].isFaceUp = false
//        } else {
//            cards[index].isFaceUp = true
//        }
        
        // MARK: 真正的游戏规则
        if !cards[index].isMatched {                                                //如果被点击按钮所对应的卡牌未匹配则执行下边规则,如果卡牌是已经匹配过的不做任何动作
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {      //令matchIndex等于待匹配卡牌且当前被点击按钮不是重复点击
                if cards[matchIndex].identifier == cards[index].identifier {                //如果待匹配卡牌身份等于当前卡牌身份
                    cards[matchIndex].isMatched = true                                          //两张卡牌都将进入匹配状态
                    cards[index].isMatched = true
                }                                                                           //如果待匹配卡牌身份不等于当前卡牌身份
                cards[index].isFaceUp = true                                                    //将当前卡牌朝上
                indexOfOneAndOnlyFaceUpCard = nil                                               //待匹配卡牌值nil进入下一轮
            } else {                                                                    //如果是重复点击
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false                                   //将所有卡牌朝下
                }
                cards[index].isFaceUp = true                                                //将当前卡牌朝上
                indexOfOneAndOnlyFaceUpCard = index                                         //将待匹配卡牌标记为当前卡牌
            }
        }
        
    }
    
    // MARK: 使用卡牌对数进行游戏初始化
    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]                                                   //生成两张一模一样的卡牌放入游戏自带的数组中
        }
        for card in cards {
            print("\(card.identifier)")
        }
    }
    
    // TODO: 洗牌
    func shuffleCards() {
        
    }
}