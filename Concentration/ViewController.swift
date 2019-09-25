//
//  ViewController.swift
//  Concentration
//
//  Created by 杨俊艺 on 2019/9/25.
//  Copyright © 2019 杨俊艺. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var flipCountLabel: UILabel!//指向显示点击次数的标签
    @IBOutlet var cardButtons: [UIButton]!//集合所有的按钮统一管理
    
    var emojiChoices = ["🇺🇸", "🇨🇦", "🇨🇳", "🇩🇪", ]
    
    var flipCount: Int = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        //获得被点击的那个按钮在按钮集合中的下标,返回值是可选类型,如果按钮没有关联到按钮集合进行统一管理则那个按钮并不在按钮集合中,就找不到,返回nil
        let cardNumber = cardButtons.firstIndex(of: sender)!//-->强制解析可选类型,如果没有则crash//let cardNumber = cardButtons.firstIndex(of: sender)//不采用宽松政策
        
        flipCard(withEmoji: emojiChoices[cardNumber], on: sender)//每个按钮对应一个emoji表情
        
        //print("cardNumber = \(String(describing: cardNumber))")
    }
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: UIControl.State.normal)
            button.backgroundColor = UIColor.orange
        }else{
            button.setTitle(emoji, for: UIControl.State.normal)
            button.backgroundColor = UIColor.white
        }
    }
}
