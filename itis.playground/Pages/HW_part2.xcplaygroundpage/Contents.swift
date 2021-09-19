
import Foundation

class Fraction {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func simplify(fraction: Fraction) -> Void {
        var numeratorHolder = fraction.numerator
        var denominatorHolder = fraction.denominator
        
        while numeratorHolder != denominatorHolder {
            if numeratorHolder > denominatorHolder {
                numeratorHolder -= denominatorHolder
            } else {
                denominatorHolder -= numeratorHolder
            }
        }
        
        fraction.numerator /= numeratorHolder
        fraction.denominator /= numeratorHolder
    }
    
    
    func commonDenominator (fractionLeft: Fraction, fractionRight: Fraction) -> Void {
        let denominatorHolder = fractionLeft.denominator
        fractionLeft.denominator *= fractionRight.denominator
        fractionLeft.numerator *= fractionRight.denominator
        fractionRight.denominator *= denominatorHolder
        fractionRight.numerator *= denominatorHolder
    }
    
    func sum (fractionLeft: Fraction, fractionRight: Fraction) -> Fraction {
        simplify(fraction: fractionLeft)
        simplify(fraction: fractionRight)
        if (fractionLeft.denominator != fractionRight.denominator){
            commonDenominator(fractionLeft: fractionLeft, fractionRight: fractionRight)
        }
        fractionLeft.numerator += fractionRight.numerator
        return fractionLeft
    }
    
    func substraction (fractionLeft: Fraction, fractionRight: Fraction) -> Fraction {
        simplify(fraction: fractionLeft)
        simplify(fraction: fractionRight)
        if (fractionLeft.denominator != fractionRight.denominator){
            commonDenominator(fractionLeft: fractionLeft, fractionRight: fractionRight)
        }
        fractionLeft.numerator -= fractionRight.numerator
        return fractionLeft
    }
    
    func multiply (fractionLeft: Fraction, fractionRight: Fraction) -> Fraction {
        simplify(fraction: fractionLeft)
        simplify(fraction: fractionRight)
        fractionLeft.numerator *= fractionRight.numerator
        fractionLeft.denominator *= fractionRight.denominator
        return fractionLeft
    }
    
    func division (fractionLeft: Fraction, fractionRight: Fraction) -> Fraction {
        simplify(fraction: fractionLeft)
        simplify(fraction: fractionRight)
        fractionLeft.numerator *= fractionRight.denominator
        fractionLeft.denominator *= fractionRight.numerator
        return fractionLeft
    }
    
    func output (fraction: Fraction) -> Void {
        simplify(fraction: fraction)
        print(fraction.numerator ,"/", fraction.denominator)
    }
    
}


var fractions: [Fraction] = [Fraction.init(numerator: 2, denominator: 4), Fraction.init(numerator: 6, denominator: 9), Fraction.init(numerator: 5, denominator: 5), Fraction.init(numerator: 20, denominator: 15)]
