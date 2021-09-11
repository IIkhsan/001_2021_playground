//: [Previous](@previous)

import Foundation

enum MyErrors: Error {
    case ZeroDivisionError(String)
}

struct Fraction: CustomStringConvertible, Equatable {
    
    var numerator: Int
    var denominator: Int
    
    var description: String {
        if denominator == 1 {
            return String(numerator)
        }
        return String(numerator) + "/" + String(denominator)
    }
    
    init(numerator: Int, denominator: Int) throws {
        if denominator == 0 {
            throw MyErrors.ZeroDivisionError("Division by zero")
        }
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func reduce() -> Fraction {
        var num_copy = numerator
        var den_copy = denominator
        var temp: Int
        while den_copy != 0 {
            temp = den_copy
            den_copy = num_copy % den_copy
            num_copy = temp
        }
        let newNumerator = numerator / num_copy
        let newDenominator = denominator / num_copy
        
        return try! Fraction(numerator: newNumerator, denominator: newDenominator)
    }
    
    mutating func reduceSelf() {
        let fraction = try! Fraction(numerator: numerator, denominator: denominator).reduce()
        numerator = fraction.numerator
        denominator = fraction.denominator
    }
    
    static func + (left: Fraction, right: Fraction) -> Fraction {
        let denominator = left.denominator * right.denominator
        let numerator = (denominator / left.denominator) * left.numerator +
            (denominator / right.denominator) * right.numerator
        
        return try! Fraction(numerator: numerator, denominator: denominator).reduce()
    }
    
    static func += (left: inout Fraction, right: Fraction) {
        left = left + right
    }
    
    static func - (left: Fraction, right: Fraction) -> Fraction {
        let denominator = left.denominator * right.denominator
        let numerator = (denominator / left.denominator) * left.numerator -
            (denominator / right.denominator) * right.numerator
        
        return try! Fraction(numerator: numerator, denominator: denominator).reduce()
    }
    
    static func -= (left: inout Fraction, right: Fraction) {
        left = left - right
    }
    
    static func * (left: Fraction, right: Fraction) -> Fraction {
        let numerator = left.numerator * right.numerator
        let denominator = left.denominator * right.denominator
        
        return try! Fraction(numerator: numerator, denominator: denominator).reduce()
    }
    
    static func *= (left: inout Fraction, right: Fraction) {
        left = left * right
    }
    
    static func / (left: Fraction, right: Fraction) -> Fraction {
        let numerator = left.numerator * right.denominator
        let denominator = left.denominator * right.numerator
        
        return try! Fraction(numerator: numerator, denominator: denominator).reduce()
    }
    
    static func /= (left: inout Fraction, right: Fraction) {
        left = left / right
    }
    
    static func == (left: Fraction, right: Fraction) -> Bool {
        let left = left.reduce()
        let right = right.reduce()
        return left.numerator == right.numerator && left.denominator == right.denominator
    }
}

func main() {
    
    let fraction1 = try! Fraction(numerator: 5, denominator: 4)
    let fraction2 = try! Fraction(numerator: 3, denominator: 4)
    
    print("fraction1 = \(fraction1)")
    print("fraction2 = \(fraction2)")
    
    print("fraction1 + fraction2 = \(fraction1 + fraction2)")
    print("fraction1 - fraction2 = \(fraction1 - fraction2)")
    print("fraction1 * fraction2 = \(fraction1 * fraction2)")
    print("fraction1 / fraction2 = \(fraction1 / fraction2)")

}

main()

//: [Next](@next)
