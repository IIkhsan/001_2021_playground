//: [Previous](@previous)

import Foundation

class Fraction {
    var a: Int
    var b: Int
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    func reduction() {
        var num = a
        var den = b
        var buf: Int = 1
        while den != 0 {
            buf = den
            den = num % den
            num = buf
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


func sum(secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.b = b * secondFraction.b
    answer.a = (answer.b / b) * a + (answer.b / secondFraction.b) * secondFraction.a
    answer.reduction()
    showOperation(secondFraction: secondFraction, answer: answer, type: "+")
    return answer
}

func substraction(secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.b = b * secondFraction.b
    answer.a = (answer.b / b) * a - (answer.b / secondFraction.b) * secondFraction.a
    answer.reduction()
    showOperation(secondFraction: secondFraction, answer: answer, type: "-")
    return answer
}

func multiplication(secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.b = b * secondFraction.b
    answer.a = a * secondFraction.a
    answer.reduction()
    showOperation(secondFraction: secondFraction, answer: answer, type: "*")
    return answer
}

func division(secondFraction: Fraction) -> Fraction {
    let answer = Fraction(a: 0, b: 0)
    answer.a = a * secondFraction.b
    answer.b = b * secondFraction.a
    answer.reduction()
    showOperation(secondFraction: secondFraction, answer: answer, type: "/")
    return answer
}
  
    func showOperation(secondFraction: Fraction, answer: Fraction , type: String) {
        print(showInString() + " \(type) " + secondFraction.showInString() + " = " + answer.showInString())
    }
}
// --------- Пример ----------

let f1 = Fraction(a: 3, b: 7)
let f2 = Fraction (a: 4, b: 11)

f1.showFraction()
f2.showFraction()

print("Сложение: ")
print(f1.sum(secondFraction: f2).showInString())

print("Вычитание: ")
print(f1.substraction(secondFraction: f2).showInString())

print("Умножение: ")
print(f1.multiplication(secondFraction: f2).showInString())

print("Деление: ")
print(f1.division(secondFraction: f2).showInString())
