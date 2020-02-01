//
//  ViewController.swift
//  calc
//
//  Created by Асан Шакабаев on 1/18/20.
//  Copyright © 2020 Асан Шакабаев. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let model = Calculator()
    var isFinished = true;
    @IBOutlet weak var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func RandomNumber(_ sender: UIButton) {
        resultLabel.text = String(Int.random(in: 0 ..< 1000))
        isFinished = true
    }
    @IBAction func PI(_ sender: UIButton) {
        resultLabel.text = "3.1415"
        isFinished = true
    }
    @IBAction func numberPressed(_ sender: UIButton) {
        guard
            let numberText = sender.titleLabel?.text
        else { return }
        if(isFinished){
            resultLabel.text=numberText
            if(resultLabel.text != "0"){
                isFinished = false;
            }
        }else{
            if(resultLabel.text != "0"){ resultLabel.text?.append(numberText)
            }
        }
    }
    
    
    @IBAction func operationPressed(_ sender: UIButton) {
        guard
            let numberText = resultLabel.text,
            let number = Double(numberText),
            let operation = sender.titleLabel?.text
        else {
            return
        }
        if operation == "AC" {
            isFinished = true;
            resultLabel.text = "";
        }
        resultLabel.text = ""
        model.setOperand(number: number)
        model.executeOperation(symbol: operation)
        if (operation == "√" || operation == "x!") {
            isFinished = true;
            resultLabel.text = "\(model.result)";
        }
        
        if operation == "=" {
            isFinished=true;
            resultLabel.text = "\(model.result)"
        }

    }
}

