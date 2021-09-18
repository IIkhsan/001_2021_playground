//: [Previous](@previous)

import Foundation

class Fraction{
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int,denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    
    func showFraction(){
        print("\(numerator)/\(denominator)")
    }
    
    //НОД
    func nod(fraction: Fraction) -> Int{
        var numerator = fraction.numerator
        var denominator = fraction.denominator
        while(denominator != 0){
            let buf = numerator % denominator
            numerator = denominator
            denominator = buf
        }
        return numerator
    }

    //Сокращение
    func reduce(fraction: Fraction) -> Fraction{
        return Fraction(numerator: fraction.numerator / nod(fraction: fraction), denominator: fraction.denominator / nod(fraction: fraction))
    }

    //Сложение
    func sum(firstFraction: Fraction, secondFraction: Fraction) -> Fraction {
        return reduce(fraction: Fraction(numerator:((firstFraction.denominator*secondFraction.denominator)/firstFraction.denominator)*firstFraction.numerator+((firstFraction.denominator*secondFraction.denominator)/secondFraction.denominator)*secondFraction.numerator,denominator: firstFraction.denominator*secondFraction.denominator))
    }

    //Умножение
    func multiplication(firstFraction: Fraction, secondFraction: Fraction) -> Fraction{
        return reduce(fraction:Fraction(numerator: firstFraction.numerator*secondFraction.numerator, denominator: firstFraction.denominator*secondFraction.denominator))
    }

    //Деление
    func division(firstFraction: Fraction, secondFraction: Fraction) -> Fraction{
        return reduce(fraction: Fraction(numerator: firstFraction.numerator*secondFraction.denominator, denominator: firstFraction.denominator*secondFraction.numerator))
    }

    //Вычитание
    func subtraction(firstFraction: Fraction, secondFraction: Fraction) ->Fraction {
        var result: Fraction
        let numerator = (firstFraction.denominator*secondFraction.denominator)/firstFraction.denominator*firstFraction.numerator - (firstFraction.denominator*secondFraction.denominator)/secondFraction.denominator*secondFraction.numerator
        let denominator = firstFraction.denominator*secondFraction.denominator
        
        if denominator == 0 {
            result = Fraction(numerator: 0, denominator: 0)
        } else if numerator == 0 {
            result = Fraction(numerator: 0, denominator: 0) }
        else {
            result = Fraction(numerator: numerator, denominator: denominator)
        }
        return reduce(fraction: result)
    }
}

//: [Next](@next)
