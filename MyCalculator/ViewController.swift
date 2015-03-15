//
//  ViewController.swift
//  MyCalculator
//
//  Created by Jasper Wang on 15/3/11.
//  Copyright (c) 2015 Jasper Wang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var display: UILabel!
    
    var result: Double!  // the previous typed or evaluated value
    
    var myOperator = ""  // operator
    
    var displayValue: Double!  // display value in double type
    
    /*
     * true if the display will be reset next time
     * false otherwise
     */
    var reset = false
    
    
    // both for repeat click of operator=
    var continueEval = false
    var tempValue = 0.0
    
    // memory
    var memory = 0.0
    
    @IBAction func AddDigit(sender: UIButton) {
        // disable the repeat evaluation of operator=
        if continueEval{
            myOperator = ""
            continueEval = false
        }
        if sender.currentTitle == "."{
            var validInsert = true
            for char in display.text!{
                if (char == "."){
                    validInsert = false
                }
                
            }
            if validInsert{
                display.text = display.text! + "."
            }
        }
        else if display.text == "0" || reset {
            display.text = "\(sender.tag)"
            reset = false
        }
        else{
            display.text = display.text! + "\(sender.tag)"
        }
        displayValue = NSNumberFormatter().numberFromString(display.text!)!.doubleValue
    }
    
    
    @IBAction func Operation(sender: UIButton) {
        // disable the repeat evaluation of operator=
        if continueEval{
            myOperator = ""
            continueEval = false
        }
        if let operation = sender.currentTitle{
            if myOperator == ""{
                myOperator = operation
                displayValue = NSNumberFormatter().numberFromString(display.text!)!.doubleValue
                result = displayValue
                println(displayValue)
                reset = true
                return;
            }
            else{
                evaluate()
                myOperator = operation
                reset = true
            }
        }
    }
    
    @IBAction func OperatorEqual(sender: UIButton) {
        if continueEval {
            switch myOperator {
            case "×":
                displayValue = tempValue * result
            case "÷":
                if (display.text == "0.0" || display.text == "0"){
                    println("not acceptable")
                    display.text = "N/A"
                    reset = true
                    return;
                }
                displayValue = result / tempValue
            case "+":
                displayValue = result + tempValue
            case "-":
                displayValue = result - tempValue
            default:break
            }
            display.text = "\(displayValue)"
            result = displayValue
        }
        else if myOperator == ""{
            reset = true
        }
        else{
            tempValue = displayValue
            evaluate()
            continueEval = true
            reset = true
            
        }
    }
    
    private func evaluate(){
        switch myOperator {
        case "×":
            displayValue = displayValue * result
        case "÷":
            if (display.text == "0" || display.text == "0.0"){
                println("not acceptable")
                display.text = "N/A"
                reset = true
                return;
            }
            displayValue = result / displayValue
        case "+":
            displayValue = result + displayValue
        case "-":
            displayValue = result - displayValue
        default:break
        }
        display.text = "\(displayValue)"
        result = displayValue
    }
    
    @IBAction func AllClear(sender: UIButton) {
        displayValue = 0
        result = 0
        reset = true
        memory = 0
        continueEval = false
        display.text = "0"
        myOperator = ""
    }
    
    @IBAction func MemoryClear(sender: UIButton) {
        memory = 0
        reset = true
    }
    
    @IBAction func AddMemory(sender: UIButton) {
        memory = displayValue
        reset = true
    }
    
    @IBAction func UseMemory(sender: UIButton) {
        displayValue = memory
        display.text = "\(displayValue)"
        reset = true
    }
    
    
    
    
}

