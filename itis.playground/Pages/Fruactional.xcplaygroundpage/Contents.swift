import UIKit

class Fruactional {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    func forgiveness() {
        var numerator = self.numerator
        var denominator = self.denominator
        
        while numerator != 0 && denominator != 0 {
            if(numerator % denominator  > 0) {
                let temp = numerator
                numerator = denominator
                denominator = temp % denominator
            }
            else {break}
        }
        if(denominator != 0 && numerator != 0) {
            self.numerator /= denominator
            self.denominator /= denominator
        }
    }
    
    //перегрузка методов, поэтому функции статичена 
    static func + (firstNum: Fruactional, secondNum: Fruactional) -> Fruactional {
        let number: Fruactional = Fruactional(numerator: 0, denominator: 0)
        number.denominator = firstNum.denominator * secondNum.denominator
        number.numerator = secondNum.numerator * firstNum.denominator + secondNum.denominator * firstNum.numerator
        number.forgiveness()
        return number
    }
    
    static func - (firstNum: Fruactional, secondNum: Fruactional) -> Fruactional {
        let number: Fruactional = Fruactional(numerator: 0, denominator: 0)
        number.denominator = firstNum.denominator * secondNum.denominator
        number.numerator = secondNum.denominator * firstNum.numerator - secondNum.numerator * firstNum.denominator
        number.forgiveness()
        return number
    }
    
    static func * (firstNum: Fruactional, secondNum: Fruactional) -> Fruactional {
        let number: Fruactional = Fruactional(numerator: 0, denominator: 0)
        number.denominator = firstNum.numerator * secondNum.numerator
        number.numerator = firstNum.denominator * secondNum.denominator
        number.forgiveness()
        return number
    }
    
    static func / (firstNum: Fruactional, secondNum: Fruactional) -> Fruactional {
        let number: Fruactional = Fruactional(numerator: 0, denominator: 0)
        number.denominator = firstNum.numerator * secondNum.denominator
        number.numerator = firstNum.denominator * secondNum.numerator
        number.forgiveness()
        return number
    }
}





