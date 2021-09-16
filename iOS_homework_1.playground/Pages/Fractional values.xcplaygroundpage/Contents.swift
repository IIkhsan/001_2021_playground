import Foundation

struct Fractional {
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
            self.numerator = numerator
            self.denominator = denominator
        }
    //Функция вывода
    func printFr() {
    print("\(self.numerator)/\(self.denominator)")
    }
    //Функция сокращения
    func CutBack() -> Fractional {
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
    func Sum(number1: Fractional, number2: Fractional) -> Fractional{
        let numerator = (number1.numerator * number2.denominator) + (number2.numerator * number1.denominator)
        let denominator = number1.denominator * number2.denominator
        return Fractional(numerator: numerator, denominator: denominator).CutBack()
    }
    //Функция вычитания
    func Subtraction(number1: Fractional, number2: Fractional) -> Fractional {
        let numerator = (number1.numerator * number2.denominator) - (number2.numerator * number1.denominator)
        let denominator = number1.denominator * number2.denominator
        return Fractional(numerator: numerator, denominator: denominator).CutBack()
    }
    //Функция умножения
    func Multiplier(number1: Fractional, number2: Fractional) -> Fractional {
        let numerator = number1.numerator * number2.numerator
        let denominator = number1.denominator * number2.denominator
        return Fractional(numerator: numerator, denominator: denominator).CutBack()
    }
    //Функция деления
    func Subdivision(number1: Fractional, number2: Fractional) -> Fractional {
        let numerator = number1.numerator * number2.denominator
        let denominator = number1.denominator * number2.numerator
        return Fractional(numerator: numerator, denominator: denominator).CutBack()
    }
}

print("Test:")
var threefouth: Fractional = Fractional(numerator: 3, denominator: 4)
threefouth.printFr()

var twoeigthth: Fractional = Fractional(numerator: 2, denominator: 8)
twoeigthth.printFr()
twoeigthth = twoeigthth.CutBack()
twoeigthth.printFr()

print("------")

var temp: Fractional = Fractional(numerator: -1, denominator: -1)
// +
temp = temp.Sum(number1: threefouth, number2: twoeigthth)
print("Результат сложения:")
temp.printFr()
// -
temp = temp.Subtraction(number1: threefouth, number2: twoeigthth)
print("Результат вычитания:")
temp.printFr()
// *
temp = temp.Multiplier(number1: threefouth, number2: twoeigthth)
print("Результат умножения:")
temp.printFr()
temp = temp.Subdivision(number1: threefouth, number2: twoeigthth)
print("Результат деления:")
temp.printFr()
