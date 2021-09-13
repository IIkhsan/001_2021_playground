struct Drob {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator;
        self.denominator = denominator;
    }
    
    func show() {
        print("\(numerator)/\(denominator)")
    }
}

protocol Operations {
    func subtraction(firstDrob: Drob, secondDrob: Drob) -> Drob
    func addition(firstDrob: Drob, secondDrob: Drob) -> Drob
    func multiplication(firstDrob: Drob, secondDrob: Drob) -> Drob
    func division(firstDrob: Drob, secondDrob: Drob) -> Drob
    func gcd(drob: Drob) -> Int
    func reduction(drob: Drob) -> Drob
}

struct Calculator: Operations {

    func gcd(drob: Drob) -> Int {
        var numerator = drob.numerator
        var denominator = drob.denominator
        while (denominator != 0) {
            let tmp = numerator % denominator
            numerator = denominator
            denominator = tmp
        }
        return numerator
    }
    
    func reduction(drob: Drob) -> Drob {
        let gcdValue: Int = gcd(drob: drob)
        let numerator = drob.numerator / gcdValue
        let denominator = drob.denominator / gcdValue
        let reductionDrob = Drob(numerator: numerator, denominator: denominator)
        return reductionDrob
    }
    
    func subtraction(firstDrob: Drob, secondDrob: Drob) -> Drob {
        let resultDenominator = firstDrob.denominator * secondDrob.denominator;
        let resultNumerator = resultDenominator/firstDrob.denominator * firstDrob.numerator - resultDenominator / secondDrob.denominator * secondDrob.numerator
        let result = Drob(numerator: resultNumerator, denominator: resultDenominator)
        return reduction(drob: result)
    }
    
    func addition(firstDrob: Drob, secondDrob: Drob) -> Drob {
        let resultDenominator = firstDrob.denominator * secondDrob.denominator;
        let resultNumerator = resultDenominator / firstDrob.denominator * firstDrob.numerator + resultDenominator / secondDrob.denominator * secondDrob.numerator
        let result = Drob(numerator: resultNumerator, denominator: resultDenominator)
        return reduction(drob: result)
    }
    
    func multiplication(firstDrob: Drob, secondDrob: Drob) -> Drob {
        let result = Drob(numerator: firstDrob.numerator * secondDrob.numerator, denominator: firstDrob.denominator * secondDrob.denominator)
        return reduction(drob: result)
    }
    
    func division(firstDrob: Drob, secondDrob: Drob) -> Drob {
        let result = Drob(numerator: firstDrob.numerator * secondDrob.denominator, denominator: firstDrob.denominator  * secondDrob.numerator)
        return reduction(drob: result)
    }
}
    
var drob1 = Drob(numerator: 5, denominator: 7)

var drob2 = Drob(numerator: 1, denominator: 4)

var calculator = Calculator()

var result = calculator.division(firstDrob: drob1, secondDrob: drob2).show()





