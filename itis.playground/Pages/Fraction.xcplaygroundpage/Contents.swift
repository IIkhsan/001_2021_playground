import Foundation


class Fraction{
    private var numerator: Int
    private var denominator: Int
    
    init(numerator: Int, denominator: Int){
        self.numerator = numerator
        self.denominator = denominator
    }
    
    public func getNumerator() -> Int{
        return numerator
    }
    
    public func getDenominator() -> Int{
        return denominator
    }
    
    // Сокращает дробь
    private func reduce() -> Void{
        let min = [numerator, denominator].min()
        
        for i in 0...min!{
            if (numerator % (i + 1)) == 0, (denominator % (i + 1)) == 0 {
                numerator /= (i + 1)
                denominator /= (i + 1)
            }
        }
    }
    
    public func multiply(fraction: Fraction) -> Fraction{
        self.reduce()
        fraction.reduce()
        
        var newFraction = Fraction(numerator: numerator * fraction.getNumerator(), denominator: denominator * fraction.getDenominator())
        newFraction.reduce()

        return newFraction
    }
    
    public func divide(fraction: Fraction) -> Fraction{
        self.reduce()
        fraction.reduce()
        
        var newFraction = Fraction(numerator: numerator * fraction.getDenominator(), denominator: denominator * fraction.getNumerator())
        newFraction.reduce()

        return newFraction
    }
    
    public func add(fraction: Fraction) -> Fraction {
        self.reduce();
        fraction.reduce();
        var newFraction = Fraction(numerator: (numerator * fraction.getDenominator()) + (denominator * fraction.getNumerator()), denominator: denominator * fraction.getDenominator())
        newFraction.reduce()

        return newFraction
    }
    
    public func sub(fraction: Fraction) -> Fraction {
        self.reduce();
        fraction.reduce();
        var newFraction = Fraction(numerator: (numerator * fraction.getDenominator()) - (denominator * fraction.getNumerator()), denominator: denominator * fraction.getDenominator())
        newFraction.reduce()

        return newFraction
    }
    
    public func printFraction() -> Void {
        if numerator == denominator {
            print(numerator / denominator)
        } else if numerator == 0 || denominator == 0 {
            print(0)
        } else {
            print(String(numerator) + "/" + String(denominator))
        }
    }
}


var a = Fraction(numerator: 3, denominator: 5)
var b = Fraction(numerator: 2, denominator: 5)
var c = a.divide(fraction: b)
c.printFraction()
