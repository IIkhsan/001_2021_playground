import Foundation

// First Task

// Fisrt principle - Abstraction

protocol AbstractPhone {
    func call(outputNumber: Int)
    func ring(inputNumber: Int)
}

// Encapsulation

public class SomePhone {
    private var year: Int
    private var company: String?
    
    init(year: Int, company: String?) {
        self.year = year
        self.company = company
    }
    
    private func openConnection() {
        //
        //
    }
    
    public func call() {
        openConnection()
        print("Вызов")
    }
    
    public func ring() {
        print("Звуки вызова")
    }
}

// Inheritance

public class CellPhone {
    private var year: Int
    private var hour: Int
    
    init(year: Int, hour: Int) {
        self.year = year
        self.hour = hour
    }
    
    public func call(outputNumber: Int) {
        print("Вызов \(outputNumber)")
    }
    
    public func ring(inputNumber: Int) {
        print("Звонок \(inputNumber)")
    }
}

public class Smartphone: CellPhone {
    private var operationSystem: String
    
    init(operationSystem: String, year: Int, hour: Int) {
        self.operationSystem = operationSystem
        super.init(year: year, hour: hour)
    }
    
    public func install(program: String) {
        print("Идет установка \(program) для \(operationSystem)")
    }
}

// Polymorphism

public class User {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func callAnotherUser(number: Int, phone: AbstractPhone) {
        phone.call(outputNumber: number)
    }
}

public class ThomasEdisonPhone: AbstractPhone {
    func call(outputNumber: Int) {
        print("Номер абонента")
    }
    func ring(inputNumber: Int) {
        print("Звонок")
    }
}

public class Phone: AbstractPhone {
    func call(outputNumber: Int) {
        print("Номер абонента \(outputNumber)")
    }
    func ring(inputNumber: Int) {
        print("Звонок \(inputNumber)")
    }
}

public class VideoPhone: AbstractPhone {
    func call(outputNumber: Int) {
        print("Подключаю \(outputNumber)")
    }
    
    func ring(inputNumber: Int) {
        print("Видеовызов \(inputNumber)")
    }
}

var user = User(name: "Renat")
var thomasEdisonPhone: AbstractPhone = ThomasEdisonPhone()
var phone: AbstractPhone = Phone()
var videoPhone: AbstractPhone = VideoPhone()

user.callAnotherUser(number: 1234567, phone: thomasEdisonPhone)
user.callAnotherUser(number: 7654321, phone: phone)
user.callAnotherUser(number: 7777777, phone: videoPhone)

// Second Task

protocol Operations {
    func multiplication(firstFraction: Fraction, secondFraction: Fraction) -> Fraction
    func division(firstFraction: Fraction, secondFraction: Fraction) -> Fraction
    func addition(firstFraction: Fraction, secondFraction: Fraction) -> Fraction
    func subtraction(firstFraction: Fraction, secondFraction: Fraction) -> Fraction
}

struct Fraction {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func output() {
        print("\(numerator) / \(denominator)")
    }
}

struct Manipulations: Operations {
    
    func gcd(fraction: Fraction) -> Int {
        var temporaryNumerator  = fraction.numerator
        var temporaryDenominator = fraction.denominator
        while temporaryDenominator != 0 {
            let temporary = temporaryNumerator % temporaryDenominator
            temporaryNumerator = temporaryDenominator
            temporaryDenominator = temporary
        }
        return temporaryNumerator
    }
    func fractionReduction(fraction: Fraction) ->  Fraction {
        let temporaryGCD = gcd(fraction: fraction)
        let temporaryNumerator = fraction.numerator / temporaryGCD
        let temporaryDenominator  = fraction.denominator / temporaryGCD
        let reductionFraction = Fraction(numerator: temporaryNumerator, denominator: temporaryDenominator)
        return reductionFraction
    }
    func multiplication(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
        let temporaryResult = Fraction(numerator: firstFraction.numerator * secondFraction.numerator, denominator: firstFraction.denominator * secondFraction.denominator)
        return fractionReduction(fraction: temporaryResult)
    }
    func division(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
        let temporaryResult = Fraction(numerator: firstFraction.numerator * secondFraction.denominator, denominator: firstFraction.denominator * secondFraction.numerator)
        return fractionReduction(fraction: temporaryResult)
    }
    func addition(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
        let temporaryDenominator = firstFraction.denominator * secondFraction.denominator
        let temporaryNumerator = (temporaryDenominator / firstFraction.denominator * firstFraction.numerator) + (temporaryDenominator / secondFraction.denominator * secondFraction.numerator)
        let temporaryResult = Fraction(numerator: temporaryNumerator, denominator: temporaryDenominator)
        return fractionReduction(fraction: temporaryResult)
    }
    func subtraction(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
        let temporaryDenominator = firstFraction.denominator * secondFraction.denominator
        let temporaryNumerator = (temporaryDenominator / firstFraction.denominator * firstFraction.numerator) - (temporaryDenominator / secondFraction.denominator * secondFraction.numerator)
        let temporaryResult = Fraction(numerator: temporaryNumerator, denominator: temporaryDenominator)
        return fractionReduction(fraction: temporaryResult)
    }
}

let firstFraction: Fraction = Fraction(numerator: 1, denominator: 2)
let secondFraction: Fraction = Fraction(numerator: 3, denominator: 7)
let manipulation = Manipulations()
var manipulationResult: () = manipulation.addition(firstFraction: firstFraction, secondFraction: secondFraction).output()

manipulationResult = manipulation.subtraction(firstFraction: firstFraction, secondFraction: secondFraction).output()
manipulationResult = manipulation.multiplication(firstFraction: firstFraction, secondFraction: secondFraction).output()
manipulationResult = manipulation.division(firstFraction: firstFraction, secondFraction: secondFraction).output()







