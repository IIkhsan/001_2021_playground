
import Foundation

class Fraction {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
}

var a = Fraction(numerator: 2, denominator: 4)
var b = Fraction(numerator: 6, denominator: 9)
var c = Fraction(numerator: 5, denominator: 5)
var d = Fraction(numerator: 20, denominator: 15)


func simplify(fr: Fraction) -> Void {
    var numeratorHolder = fr.numerator
    var denominatorHolder = fr.denominator
    
    while numeratorHolder != denominatorHolder {
        if numeratorHolder > denominatorHolder {
            numeratorHolder -= denominatorHolder
        } else {
            denominatorHolder -= numeratorHolder
        }
    }

    fr.numerator /= numeratorHolder
    fr.denominator /= numeratorHolder
}

func commonDenominator (fr1: Fraction, fr2: Fraction) -> Void {
    let denominatorHolder = fr1.denominator
    fr1.denominator *= fr2.denominator
    fr1.numerator *= fr2.denominator
    fr2.denominator *= denominatorHolder
    fr2.numerator *= denominatorHolder
}

func sum (fr1: Fraction, fr2: Fraction) -> Fraction {
    simplify(fr: fr1)
    simplify(fr: fr2)
    if (fr1.denominator != fr2.denominator){
        commonDenominator(fr1: fr1, fr2: fr2)
    }
    fr1.numerator += fr2.numerator
    return fr1
}

func substraction (fr1: Fraction, fr2: Fraction) -> Fraction {
    simplify(fr: fr1)
    simplify(fr: fr2)
    if (fr1.denominator != fr2.denominator){
        commonDenominator(fr1: fr1, fr2: fr2)
    }
    fr1.numerator -= fr2.numerator
    return fr1
}

func multiply (fr1: Fraction, fr2: Fraction) -> Fraction {
    simplify(fr: fr1)
    simplify(fr: fr2)
    fr1.numerator *= fr2.numerator
    fr1.denominator *= fr2.denominator
    return fr1
}

func division (fr1: Fraction, fr2: Fraction) -> Fraction {
    simplify(fr: fr1)
    simplify(fr: fr2)
    fr1.numerator *= fr2.denominator
    fr1.denominator *= fr2.numerator
    return fr1
}

func output (fr: Fraction) -> Void {
    simplify(fr: fr)
    print(fr.numerator ,"/", fr.denominator)
}

sum(fr1: a, fr2: b)
output(fr: a)

