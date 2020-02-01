//
//  Calculator.swift
//  calc
//
//  Created by Асан Шакабаев on 2/1/20.
//  Copyright © 2020 Асан Шакабаев. All rights reserved.
//

import Foundation


class Calculator {
    // MARK: - Constants
    enum Operation {
        case equals
        case constant(value: Double)
        case unary(function: (Double) -> Double)
        case binary(function: (Double, Double) -> Double)
        case clearall
        case clearlast
    }
    
    var map: [String : Operation] = [
        "+" : .binary { $0 + $1 },
        "*" : .binary { $0 * $1},
        "-" : .binary { $0 - $1},
        "/" : .binary {$0 / $1},
        "=" : .equals,
        "π" : .constant(value: 3.14159),
        "AC": .clearall,
        "%" : .binary{$0.truncatingRemainder(dividingBy:$1)},
        "√" : .unary{sqrt($0)},
        "xY": .binary{pow($0,$1)},
        "C" : .clearlast,
        "x!": .unary(function: { (value) -> Double in
            var fact: Int = 1
            var n = Int(value)+1
            for i in 1..<n {
                fact = fact * i
            }
            return Double(fact)
        })
//        "R" : .unary{$0},
    ]
        
    // MARK: - Variables
    var result: Double = 0
    var lastBinaryOperation: ((Double, Double) -> Double)?
    var reminder: Double = 0
    
    // MARK: - Methods
    func setOperand(number: Double) {
        result = number
    }
    
    func executeOperation(symbol: String) {
        guard let operation = map[symbol] else {
            print("ERROR: no such symbol in map")
            return
        }
        
        switch operation {
        case .constant(let value):
            result = value
        case .unary(let function):
            result = function(result)
            result =  Double(round(1000*result)/1000)
        case .binary(let function):
            if lastBinaryOperation != nil {
                executeOperation(symbol: "=")
            }
            lastBinaryOperation = function
            reminder = result
        case .equals:
            if let lastOperation = lastBinaryOperation {
                result = lastOperation(reminder, result)
                result =  Double(round(1000*result)/1000)
                lastBinaryOperation = nil
                reminder = 0
            }
        case .clearall:
            result = 0
            lastBinaryOperation=nil
            reminder = 0
        case .clearlast:
            result = 0
        }
    }
}
