//
//  ViewController.swift
//  calculator
//
//  Created by 廖昱晴 on 2021/2/25.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    var numberOnScreen: Double = 0 //計算機目前顯示的文字
    var previousNumber: Double = 0 //記錄按下計算符號之前的數字
    var performingMath: Bool = false //是否正在運算
    var operation = "none" //記錄運算模式
    var startingNew = true //是否為全新的運算
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func numbers(_ sender: UIButton) { //按數字鍵觸發
        let inputNumber = sender.tag - 1
        
        if label.text != nil {
            if startingNew {
                label.text = "\(inputNumber)" //顯示按下的數字
                startingNew = false
            } else {
                if label.text == "0" || label.text == "+" || label.text == "-" || label.text == "x" || label.text == "/"{
                    label.text = "\(inputNumber)"
                } else {
                    label.text = label.text! + "\(inputNumber)" //label繼續增加按下的數字字串
                }
            }
            numberOnScreen = Double(label.text!) ?? 0 //數字轉型為double，並存入numberOnScreen
        }
        
    }
    
    @IBAction func clear(_ sender: UIButton) {
        label.text = "0"
        numberOnScreen = 0
        previousNumber = 0
        performingMath = false
        operation = "none"
        startingNew = true
    }
    
    @IBAction func add(_ sender: UIButton) {
        label.text = "+"
        operation = "add"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func subStract(_ sender: UIButton) {
        label.text = "-"
        operation = "substract"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func multiply(_ sender: UIButton) {
        label.text = "x"
        operation = "multiply"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func divide(_ sender: UIButton) {
        label.text = "/"
        operation = "divide"
        performingMath = true
        previousNumber = numberOnScreen
    }
    
    @IBAction func giveMeAnswer(_ sender: UIButton) {
        if performingMath {
            switch operation {
                case "add":
                    numberOnScreen = previousNumber + numberOnScreen
                    makeOkNumberString(from: numberOnScreen)
                case "substract":
                    numberOnScreen = previousNumber - numberOnScreen
                    makeOkNumberString(from: numberOnScreen)
                case "multiply":
                    numberOnScreen = previousNumber * numberOnScreen
                    makeOkNumberString(from: numberOnScreen)
                case "divide":
                    numberOnScreen = previousNumber / numberOnScreen
                    makeOkNumberString(from: numberOnScreen)
                default:
                    label.text = "0"
            }
            performingMath = false
            startingNew = true
        }
    }
    
    func makeOkNumberString(from number: Double) {
        var okText: String
        if floor(number) == number { //小數如果是0就顯示整數
            okText = "\(Int(number))"
        } else {
            okText = "\(number)"
        }
        if okText.count >= 9 { //位數最多9位
            okText = String(okText.prefix(9))
        }
        label.text = okText
    }
    
}

