import UIKit

// Abstract

class Dog{
    var name: String;
    
    init(name: String) {
        self.name = name
    }
    
    static func doVoice() -> Void{
        print("Gav")
    }
}


// Encapsulation

class Cat{
    public var name: String;
    private var yearOfBirth: Int
    
    init(name: String, yearOfBirth: Int) {
        self.name = name
        self.yearOfBirth = yearOfBirth
    }
    
    public func cleanItself() -> Void{
        print("Cat cleaned itself!")
    }
}

// Inheritance

class Animal{
    public var name: String;
    
    init(name: String) {
        self.name = name
    }
    
    public func getName() -> Void{
        print(self.name)
    }
}


class Lion: Animal{
    public var age: Int
    
    init(age: Int, name: String) {
        self.age = age
        super.init(name: name)
    }
}



// Polymorphism

class Bird{
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    public func introduceItself() -> Void{
        print("I'm a bird!")
    }
}


class Eagle{
    var age: Int
    
    init(name: String, age: Int) {
        self.age = age
        Bird.init(name: name)
    }
    
    public func introduceItself() -> Void{
        print("I'm an \(self.age) years old Eagle bird!")
    }
}


//--------------------------------------------------------------------------



struct FractionalNumber{
    var numerator: Int
    var denominator: Int
    
    init(numerator: Int, denominator: Int) {
        self.numerator = numerator
        self.denominator = denominator
    }
    
    public func PrintOut() -> Void{
        print("\(self.numerator)/\(self.denominator)")
    }
}

func Addition(firstFractionalNumber: FractionalNumber, secondFractionalNumber: FractionalNumber) -> FractionalNumber{
    return FractionalNumber(numerator: firstFractionalNumber.numerator*secondFractionalNumber.denominator + secondFractionalNumber.numerator*firstFractionalNumber.denominator,
                            denominator: firstFractionalNumber.denominator*secondFractionalNumber.denominator)
}

func Subtraction(firstFractionalNumber: FractionalNumber, secondFractionalNumber: FractionalNumber) -> FractionalNumber{
    return FractionalNumber(numerator: firstFractionalNumber.numerator*secondFractionalNumber.denominator - secondFractionalNumber.numerator*firstFractionalNumber.denominator,
                            denominator: firstFractionalNumber.denominator*secondFractionalNumber.denominator)
}
func Multiplication(firstFractionalNumber: FractionalNumber, secondFractionalNumber: FractionalNumber) -> FractionalNumber{
    return FractionalNumber(numerator: firstFractionalNumber.numerator*secondFractionalNumber.numerator,
                            denominator: firstFractionalNumber.denominator*secondFractionalNumber.denominator)
}

func Division(firstFractionalNumber: FractionalNumber, secondFractionalNumber: FractionalNumber) -> FractionalNumber{
    let tempFractionalNumber = FractionalNumber(numerator: secondFractionalNumber.denominator, denominator: secondFractionalNumber.numerator)
    return Addition(firstFractionalNumber: firstFractionalNumber, secondFractionalNumber: tempFractionalNumber)
}



