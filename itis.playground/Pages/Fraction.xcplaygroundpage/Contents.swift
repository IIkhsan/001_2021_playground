import Foundation

struct Fraction {
    var upperNumber: Int
    var underNumber: Int
    
    init(a: Int, b: Int) {
        self.upperNumber = a
        self.underNumber = b
    }
    
    mutating func NOD() {
        var secondUpper: Int = upperNumber
        var secondUnder: Int = underNumber
        var buf: Int = 0
        while secondUnder != 0 {
            buf = secondUnder
            secondUnder = secondUpper % secondUnder
            secondUpper = buf
        }
       upperNumber = upperNumber / secondUpper
        underNumber = underNumber / secondUnder
    }
    
    func show() {
        var buf: Int = 0
        buf = upperNumber % underNumber
        if buf != 0 {
            print(upperNumber/underNumber)
        } else {
            print("\(upperNumber) / \(underNumber)")
        }
    }
}
struct addSubMultDrob {
    var ob1: Fraction
    var ob2: Fraction
    
    init(a: Int, b: Int, a1: Int, b1: Int) {
        var s: Fraction
        s = Fraction.init(a: a, b: b)
        var s1: Fraction
        s1 = Fraction.init(a: a1, b: b1)
        ob1 = s
        ob2 = s1
    }
    
    func operatorSum (ob1: Fraction, ob2: Fraction) -> Fraction {
        var temp: Fraction
        temp = Fraction.init(a: 0, b: 0)
        temp.underNumber = ob1.underNumber * ob2.underNumber
        temp.upperNumber = (temp.underNumber / ob1.underNumber) * ob1.upperNumber  - (temp.underNumber / ob2.underNumber) * ob2.upperNumber
        return temp
    }
    
    func operatorMult(ob1: Fraction, ob2: Fraction) -> Fraction {
        var temp: Fraction
        temp = Fraction.init(a: 0, b: 0)
        temp.underNumber = ob1.underNumber * ob2.underNumber
        temp.upperNumber = ob1.upperNumber * ob2.upperNumber
        return temp
    }
    func showSubMult() {
        print("First fraction \(ob1.upperNumber) / \(ob1.underNumber)")
        print("Second drob \(ob2.upperNumber) / \(ob2.underNumber)")
    }
}


