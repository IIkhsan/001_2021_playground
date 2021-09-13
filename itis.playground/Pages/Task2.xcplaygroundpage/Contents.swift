//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"


class Fraction {
    var a: Int
    var b: Int
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    func reduction() {
        var num = a //6
        var den = b //14
        var buf: Int = 1
        while den != 0 {
            buf = den // 14
            den = num % den //14
            num = buf //  14
            
        }
        a = a / num
        b = b / num
        
        
        
    }
    func showFraction() {
        print("\(a)/\(b)")
    }
    func showInString() -> String {
        let answer = "\(a)/\(b)"
        return answer
    }
    
   
}

func sum(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.b = firstFraction.b * secondFraction.b
    answer.a = (answer.b / firstFraction.b) * firstFraction.a + (answer.b / secondFraction.b) * secondFraction.a
    answer.reduction()
    showOperation(firstFraction: firstFraction, secondFraction: secondFraction, answer: answer, type: "+")
    return answer
}

func substraction(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.b = firstFraction.b * secondFraction.b
    answer.a = (answer.b / firstFraction.b) * firstFraction.a - (answer.b / secondFraction.b) * secondFraction.a
    answer.reduction()
    showOperation(firstFraction: firstFraction, secondFraction: secondFraction, answer: answer, type: "-")
    return answer
}

func multiplication(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.b = firstFraction.b * secondFraction.b
    answer.a = firstFraction.a * secondFraction.a
    answer.reduction()
    showOperation(firstFraction: firstFraction, secondFraction: secondFraction, answer: answer, type: "*")
    return answer
}

func division(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.a = firstFraction.a * secondFraction.b
    answer.b = firstFraction.b * secondFraction.a
    answer.reduction()
    showOperation(firstFraction: firstFraction, secondFraction: secondFraction, answer: answer, type: "/")
    
    return answer
}

func showOperation(firstFraction: Fraction, secondFraction: Fraction, answer: Fraction , type: String) {
    print(firstFraction.showInString() + " \(type) " + secondFraction.showInString() + " = " + answer.showInString())
}




// --------- Пример ----------

let f1 = Fraction(a: 3, b: 7)
let f2 = Fraction (a: 4, b: 11)

f1.showFraction()
f2.showFraction()

print("Сложение: ")
sum(firstFraction: f1, secondFraction: f2)

print("Вычитание: ")
substraction(firstFraction: f1, secondFraction: f2)

print("Умножение: ")
multiplication(firstFraction: f1, secondFraction: f2)

print("Деление: ")
division(firstFraction: f1, secondFraction: f2)

