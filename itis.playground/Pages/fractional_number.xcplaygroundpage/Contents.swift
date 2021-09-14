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
        var numCopy = numerator
        var denCopy = denominator
        var temp: Int
        while denCopy != 0 {
            temp = denCopy
            denCopy = numCopy % denCopy
            numCopy = temp
        }
        let newNumerator = numerator / numCopy
        let newDenominator = denominator / numCopy
        
        guard let newfraction = try? Fraction(numerator: newNumerator, denominator: newDenominator) else {
            return self
        }
        return newfraction
    }
    
    mutating func reduceSelf() {
        guard let fraction = try? Fraction(numerator: numerator, denominator: denominator).reduce() else { return }
        numerator = fraction.numerator
        denominator = fraction.denominator
    }
    
    static func + (left: Fraction, right: Fraction) -> Fraction {
        let denominator = left.denominator * right.denominator
        let numerator = (denominator / left.denominator) * left.numerator +
            (denominator / right.denominator) * right.numerator
        
        if let newFraction = try? Fraction(numerator: numerator, denominator: denominator).reduce() {
            return newFraction
        }
        return left
    }
    
    static func += (left: inout Fraction, right: Fraction) {
        left = left + right
    }
    
    static func - (left: Fraction, right: Fraction) -> Fraction {
        let denominator = left.denominator * right.denominator
        let numerator = (denominator / left.denominator) * left.numerator -
            (denominator / right.denominator) * right.numerator
        
        if let newFraction = try? Fraction(numerator: numerator, denominator: denominator).reduce() {
            return newFraction
        }
        return left
    }
    
    static func -= (left: inout Fraction, right: Fraction) {
        left = left - right
    }
    
    static func * (left: Fraction, right: Fraction) -> Fraction {
        let numerator = left.numerator * right.numerator
        let denominator = left.denominator * right.denominator
        
        if let newFraction = try? Fraction(numerator: numerator, denominator: denominator).reduce() {
            return newFraction
        }
        return left
    }
    
    static func *= (left: inout Fraction, right: Fraction) {
        left = left * right
    }
    
    static func / (left: Fraction, right: Fraction) -> Fraction {
        let numerator = left.numerator * right.denominator
        let denominator = left.denominator * right.numerator
        
        if let newFraction = try? Fraction(numerator: numerator, denominator: denominator).reduce() {
            return newFraction
        }
        return left
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
    
    guard let fraction1 = try? Fraction(numerator: 5, denominator: 4) else { return }
    guard let fraction2 = try? Fraction(numerator: 3, denominator: 4) else { return }
    
    print("fraction1 = \(fraction1)")
    print("fraction2 = \(fraction2)")
    
    print("fraction1 + fraction2 = \(fraction1 + fraction2)")
    print("fraction1 - fraction2 = \(fraction1 - fraction2)")
    print("fraction1 * fraction2 = \(fraction1 * fraction2)")
    print("fraction1 / fraction2 = \(fraction1 / fraction2)")

}

main()

//: [Next](@next)
