import Foundation

struct Fractional {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
            self.numerator = numerator
            self.denominator = denominator
        }
    //Функция вывода
    func printFraction() {
    print("\(self.numerator)/\(self.denominator)")
    }
    //Функция сокращения
    func cutBack() -> Fractional {
        var newNumerator = numerator
        var newDenominator = denominator
        var temp: Int

        while (newDenominator != 0) {
            temp = newDenominator;
            newDenominator = newNumerator % newDenominator;
            newNumerator = temp;
        }
        
        let resultNumerator = numerator / newNumerator
        let resultDenominator = denominator / newNumerator
        
        return Fractional(numerator: resultNumerator, denominator: resultDenominator)
    }
    //Функция суммы
    func sum(number1: Fractional, number2: Fractional) -> Fractional{
        let numerator = (number1.numerator * number2.denominator) + (number2.numerator * number1.denominator)
        let denominator = number1.denominator * number2.denominator
        return Fractional(numerator: numerator, denominator: denominator).cutBack()
    }
    //Функция вычитания
    func subtraction(number1: Fractional, number2: Fractional) -> Fractional {
        let numerator = (number1.numerator * number2.denominator) - (number2.numerator * number1.denominator)
        let denominator = number1.denominator * number2.denominator
        return Fractional(numerator: numerator, denominator: denominator).cutBack()
    }
    //Функция умножения
    func multiplier(number1: Fractional, number2: Fractional) -> Fractional {
        let numerator = number1.numerator * number2.numerator
        let denominator = number1.denominator * number2.denominator
        return Fractional(numerator: numerator, denominator: denominator).cutBack()
    }
    //Функция деления
    func subdivision(number1: Fractional, number2: Fractional) -> Fractional {
        let numerator = number1.numerator * number2.denominator
        let denominator = number1.denominator * number2.numerator
        return Fractional(numerator: numerator, denominator: denominator).cutBack()
    }
}

print("Test:")
var threefouth: Fractional = Fractional(numerator: 3, denominator: 4)
threefouth.printFraction()

var twoeigthth: Fractional = Fractional(numerator: 2, denominator: 8)
twoeigthth.printFraction()
twoeigthth = twoeigthth.cutBack()
twoeigthth.printFraction()

print("------")

var temp: Fractional = Fractional(numerator: -1, denominator: -1)
// +
temp = temp.sum(number1: threefouth, number2: twoeigthth)
print("Результат сложения:")
temp.printFraction()
// -
temp = temp.subtraction(number1: threefouth, number2: twoeigthth)
print("Результат вычитания:")
temp.printFraction()
// *
temp = temp.multiplier(number1: threefouth, number2: twoeigthth)
print("Результат умножения:")
temp.printFraction()
temp = temp.subdivision(number1: threefouth, number2: twoeigthth)
print("Результат деления:")
temp.printFraction()
