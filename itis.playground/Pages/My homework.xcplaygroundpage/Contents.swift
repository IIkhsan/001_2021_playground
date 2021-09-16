//: [Previous](@previous)

import Foundation

class PhoneWithEncapsulation {
    private let prodYear: Int;
    private let company: String
    
    init(year: Int, company: String) {
        prodYear = year
        self.company = company
    }
    
    public func call() -> Void {
        print("Encapsulation")
    }
}

class AbstractPhone {
    func call(number: Int) -> Void { }
    func ring(melody: String) -> Void { }
}

class WirelessPhone: AbstractPhone {
    override func call(number: Int) {
        print("calling to ", number)
    }
    
    override func ring(melody: String) {
        print(melody)
    }
}

//: [Next](@next)


class Fraction{
    var numerator: Int
    var denominator: Int
    
    init(numer: Int, denom: Int) {
        self.numerator = numer
        self.denominator = denom
    }
    
    func reduce() -> Fraction{
        
        let isPositive = numerator > 0
        
        var n = isPositive ? numerator : -numerator
        var d = denominator
        
        
        while n != 0, d != 0 {
            if n>d {
                n = n%d
            } else {
                d = d%n
            }
        }
        
        if (d+n != 0) {
            self.numerator = numerator / (n+d)
            self.denominator = denominator / (n+d)
        }
        return Fraction(numer: numerator, denom: denominator)
    }
    
    func multiply(factor: Fraction) -> Fraction {
        let result = Fraction(numer: self.numerator * factor.numerator
                              , denom: self.denominator * factor.denominator)
        return result.reduce()
    }
    
    func division(divider: Fraction) -> Fraction {
        self.multiply(factor: Fraction(numer: divider.denominator
                                       , denom: divider.numerator))
    }
    
    func addition(term: Fraction) -> Fraction {
        var n = self.numerator * term.denominator + term.numerator * self.denominator
        var d = self.denominator * term.denominator
        
        return Fraction(numer: n, denom: d).reduce()
    }
    
    func subtraction(subtrahend: Fraction) -> Fraction {
        var n = self.numerator * subtrahend.denominator - subtrahend.numerator * self.denominator
        var d = self.denominator * subtrahend.denominator
        
        return Fraction(numer: n, denom: d).reduce()
    }
    
    func printF() -> Void {
        print(numerator, "/", denominator)
    }
    
}

// резудьтат не сохраняется в дробь
var frac = Fraction(numer: 10, denom: 15)
frac.multiply(factor: Fraction(numer: 2, denom: 4))
frac.division(divider: Fraction(numer: 2, denom: 4))
frac.addition(term: Fraction(numer: 1, denom: 2))
frac.subtraction(subtrahend: Fraction(numer: 4, denom: 3))
frac.printF()
