//
//  ViewController.swift
//  calculatorApp
//
//  Created by VERTEX21 on 2019/08/15.
//  Copyright © 2019 k-kougi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 画面に表示されている数字
    var numberOnScreen: Double = 0
    // 前回表示されていた数字
    var previousNumber: Double = 0
    // 数値が入力されたかどうかの判断値（真偽値）
    var inValue = false
    // 計算プロセスに進んでいいかの判断値（真偽値）
    var performingMath = false
    
    var operation = 0
    
    // 計算結果を表示するラベル
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
         label.text = ""
    }
    
    //数字ボタン
    @IBAction func buttonNum(_ sender: UIButton) {
        // +, -, *, / が押されていた時
        if performingMath == true {
            // ラベルに押したボタンの数字を表示
            label.text = String(sender.tag)
            // 表示されてる数字を代入
            numberOnScreen = Double(label.text!)!
            performingMath = false
        } else {
            //すでに表示されてる数字に押した数字を追加
            label.text = label.text! + String(sender.tag)
            // 表示されてる数字を代入
            numberOnScreen = Double(label.text!)!
        }
        // 数値が入力された
        inValue = true
    }
    
    //記号ボタン
    @IBAction func buttonAction(_ sender: UIButton) {
        if label.text != "" && sender.tag != 11 && sender.tag != 16 {
            // 【ラベルが空白の時、＝を押した時、Cを押した時以外】
            if inValue {
                // 数値が入力されていた場合のみpreviousNumber に表示されている数字を代入
                previousNumber = Double(label.text!)!
            }
            
            // ラベルに記号を表示
            //割り算
            if sender.tag == 12 {
                label.text = "÷"
                //掛け算
            } else if sender.tag == 13 {
                label.text = "×"
                //引き算
            } else if sender.tag == 14 {
                label.text = "-"
                //足し算
            } else if sender.tag == 15 {
                label.text = "+"
            }
            // operationに押した四則計算のタグ番号を代入
            operation = sender.tag
            // 計算できる
            performingMath = true
            // 数値ではない
            inValue = false
            
            // = が押されたとき
        } else if sender.tag == 16 {
            // 割り算の時0で割ってたらエラー
            if operation == 12 {
                if numberOnScreen == 0 {
                    label.text = "エラー"
                } else {
                    let num = String(previousNumber / numberOnScreen).components(separatedBy: ".")
                    if num[1] == "0" {
                        // 少数でない時
                        label.text = num[0]
                    } else {
                        label.text = String(previousNumber / numberOnScreen)
                    }
                }
                
            } else if operation == 13 {
                let num = String(previousNumber * numberOnScreen).components(separatedBy: ".")
                if num[1] == "0" {
                    // 少数でない時
                    label.text = num[0]
                } else {
                    label.text = String(previousNumber * numberOnScreen)
                }
                
            } else if operation == 14 {
                let num = String(previousNumber - numberOnScreen).components(separatedBy: ".")
                if num[1] == "0" {
                    // 少数でない時
                    label.text = num[0]
                } else {
                    label.text = String(previousNumber - numberOnScreen)
                }
                
            } else if operation == 15 {
                let num = String(previousNumber + numberOnScreen).components(separatedBy: ".")
                if num[1] == "0" {
                    // 少数でない時
                    label.text = num[0]
                } else {
                    label.text = String(previousNumber + numberOnScreen)
                }
            }
        } else if sender.tag == 11 {
            // C が押された時
            label.text = ""
            previousNumber = 0
            numberOnScreen = 0
            operation = 0
            inValue = false
            performingMath = false
        }
}

}
