
import Foundation

struct Drob {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func show(){
        print("\(numerator)/\(denominator)")
    }
    
    
    func NOD() -> Drob{
        var a: Int = numerator
        var b: Int = denominator
        if a > 0 && b > 0 {
            while (a != b){
                if a > b {
                    a -= b
                } else {
                    b -= a
                }
            }
        } else {
            a *= -1
            while a != b {
                if a > b {
                    a -= b
                } else {
                    b -= a
                }
            }
        }
        return Drob(numerator: numerator/a , denominator: denominator/b)
    }
}

struct Calculator {
    var drob1: Drob
    var drob2: Drob
    
    init(drob1: Drob, drob2: Drob) {
        self.drob1 = drob1
        self.drob2 = drob2
    }
    
    func addition() -> Drob {
        let resultDenominator = drob1.denominator * drob2.denominator;
        let resultNumerator = resultDenominator / drob1.denominator * drob1.numerator + resultDenominator / drob2.denominator * drob2.numerator
        return Drob(numerator: resultNumerator, denominator: resultDenominator).NOD()
    }
    
    func subtraction() -> Drob {
        let resultDenominator = drob1.denominator * drob2.denominator;
        let resultNumerator = resultDenominator / drob1.denominator * drob1.numerator - resultDenominator / drob2.denominator * drob2.numerator
        return Drob(numerator: resultNumerator, denominator: resultDenominator).NOD()
    }
    
    func multiplication() -> Drob {
        return Drob(numerator: drob1.numerator * drob2.numerator, denominator: drob1.denominator * drob2.denominator).NOD()
    }
    
    func division() -> Drob {
        return Drob(numerator: drob1.numerator * drob2.denominator, denominator: drob1.denominator * drob2.numerator).NOD()
    }
}


print(Calculator(drob1: Drob(numerator: 12, denominator: 100), drob2: Drob(numerator: 23, denominator: 56)).division())

