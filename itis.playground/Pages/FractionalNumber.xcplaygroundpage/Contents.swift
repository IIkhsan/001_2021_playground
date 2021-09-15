//: [Previous](@previous)

import Foundation

struct FractionalNumber {
    var numerator: Int
    var denominator: Int
    
    static func printNormalFractionalNumber(num: FractionalNumber) {
        print("\(num.numerator)/\(num.denominator)")
    }
    
    func reduction() -> FractionalNumber {
        var newNumerator = numerator
        var newDenominator = denominator
        var temp: Int

        while (newDenominator != 0) {
            temp = newDenominator;
            newDenominator = newNumerator % newDenominator;
            newNumerator = temp;
        }
        
        let finalNumerator = numerator / newNumerator
        let finalDenominator = denominator / newNumerator
        
        return FractionalNumber(numerator: finalNumerator, denominator: finalDenominator)
    }
    
    static func +(num1: FractionalNumber, num2: FractionalNumber) -> FractionalNumber {
        let denominator = num1.denominator*num2.denominator
        let numerator = num1.numerator*num2.denominator + num2.numerator*num1.denominator
        
        return FractionalNumber(numerator: numerator, denominator: denominator).reduction()
    }
    
    static func -(num1: FractionalNumber, num2: FractionalNumber) -> FractionalNumber {
        let denominator = num1.denominator*num2.denominator
        let numerator = num1.numerator*num2.denominator - num2.numerator*num1.denominator
        
        return FractionalNumber(numerator: numerator, denominator: denominator).reduction()
    }
    
    static func *(num1: FractionalNumber, num2: FractionalNumber) -> FractionalNumber {
        let denominator = num1.denominator*num2.denominator
        let numerator = num1.numerator*num2.numerator
        
        return FractionalNumber(numerator: numerator, denominator: denominator).reduction()
    }
    
    static func /(num1: FractionalNumber, num2: FractionalNumber) -> FractionalNumber {
        let denominator = num1.denominator*num2.numerator
        let numerator = num1.numerator*num2.denominator
        
        return FractionalNumber(numerator: numerator, denominator: denominator).reduction()
    }
    
    init() {
        self.numerator = 0
        self.denominator = 0
    }
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
}

var num1: FractionalNumber = FractionalNumber(numerator: 4, denominator: 3)
var num2: FractionalNumber = FractionalNumber(numerator: 8, denominator: 17)

FractionalNumber.printNormalFractionalNumber(num: num1 + num2)
FractionalNumber.printNormalFractionalNumber(num: num1 - num2)
FractionalNumber.printNormalFractionalNumber(num: num1 * num2)
FractionalNumber.printNormalFractionalNumber(num: num1 / num2)
//: [Next](@next)
