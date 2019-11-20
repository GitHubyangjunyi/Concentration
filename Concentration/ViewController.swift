//
//  ViewController.swift
//  Concentration
//
//  Created by 杨俊艺 on 2019/9/25.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: 关联到视图
    @IBOutlet weak var flipCountLabel: UILabel!                                         //指向显示点击次数的标签
    @IBOutlet var cardButtons: [UIButton]!                                              //所有的按钮放入集合统一管理
    
    var flipCount: Int = 0 {                                                            //点击次数监视器
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    // MARK: 初始化游戏对象,卡牌对的数量是按钮数的一半
    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    // MARK: 当按钮被点击后的响应动作
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender){
            game.chooseCard(at: cardNumber)                                             //游戏执行选择了哪张卡牌,将被点击的那个按钮对应按钮集合中的下标传递给游戏对象执行选择卡牌操作
            updateViewFromModel()                                                       //然后更新视图信息
        } else{
            print("T##items: Any...##Any")
        }
    }
    
    // MARK: 从模型Model中获得信息并更新视图View
    func updateViewFromModel() {
        for index in cardButtons.indices {                                              //对所有视图遍历更新,目前视图只有按钮,遍历次数是按钮个数
            let button = cardButtons[index]                                                 //获得按钮
            let card = game.cards[index]                                                    //获得游戏卡牌
            
            if card.isFaceUp {                                                          //如果卡牌朝上
                button.backgroundColor = UIColor.white                                      //让按钮变白方便显示
                button.setTitle(emoji(for: card), for: UIControl.State.normal)              //从emoji字典中取出对应卡牌的emoji设为按钮标题
            } else {                                                                    //如果卡牌朝下
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.black : UIColor.orange    //如果卡牌是翻过并且已经匹配过的则将卡片变黑融于背景
            }
        }
    }
    
    var emojiChoices = ["🇺🇸", "🇨🇦", "🇨🇳", "🇩🇪", "🇩🇴", "🇫🇷", "🏴‍☠️", "🏳️‍🌈", "🇺🇳", "🇦🇺", "🇷🇺", "🇰🇷", "♻︎", "〶", "♴", "♽", "♷", "㉿", "⎈", "⌨︎", "⎆", "⚙︎", "⎊", "⎉", "⌚︎", "⎌", "⎂", "⑇", "⑈", "⑉", "⑆", ]
    var emoji =  [Int : String]()                                                       //字典映射,一个卡牌模型映射一个emoji字典模型
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {                      //用卡牌身份号去验证emoji字典中有没有映射卡牌符号,如果没有映射并且emojiChoices还有剩余就选一个emoji并让卡牌模型映射到视图控制器的字典模型中
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))       //获得随机数
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)               //映射卡牌到字典当中并将当前卡牌使用的emoji从emojiChoices中移除
            }
            return emoji[card.identifier] ?? "?"                                        //如果卡牌有映射到字典中就解包并返回emoji
    }
    
    // TODO: 开始新的游戏
}
