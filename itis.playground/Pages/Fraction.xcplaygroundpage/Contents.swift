import Foundation

struct Fraction {
    var a: Int
    var b: Int
    
    init(a: Int, b: Int) {
        self.a = a
        self.b = b
    }
    
    mutating func NOD() {
        var a_a: Int = a
        var b_b: Int = b
        var buf: Int = 0
        while b_b != 0 {
            buf = b_b
            b_b = a_a % b_b
            a_a = buf
        }
       a = a / a_a
        b = b / b_b
    }
    
    func show() {
        var buf: Int = 0
        buf = a % b
        if buf != 0 {
            print(a/b)
        } else {
            print("\(a) / \(b)")
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
        temp.b = ob1.b * ob2.b
        temp.a = (temp.b / ob1.b) * ob1.a  - (temp.b / ob2.b) * ob2.a
        return temp
    }
    
    func operatorMult(ob1: Fraction, ob2: Fraction) -> Fraction {
        var temp: Fraction
        temp = Fraction.init(a: 0, b: 0)
        temp.b = ob1.b * ob2.b
        temp.a = ob1.a * ob2.a
        return temp
    }
    func showSubMult() {
        print("First fraction \(ob1.a) / \(ob1.b)")
        print("Second drob \(ob2.a) / \(ob2.b)")
    }
}


