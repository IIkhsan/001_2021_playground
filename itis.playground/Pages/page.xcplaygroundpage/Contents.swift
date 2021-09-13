//: [Previous](@previous)

import Foundation

protocol Nameable {
    
    var name: String? { get set }
    func getFullName(secondName: String) -> String
}

extension Nameable {
    
    func getFullName(secondName: String) -> String {
        return "full name"
    }
}

class ClassA {
    var name: String {
        willSet {
            pName = newValue
        }
        
        didSet {
            pName = oldValue
        }
    }
    
    private var pName: String = ""
    
    init(name: String) {
        self.name = name
    }
}

class ClassB: Nameable {
    var name: String?
    
    init() {
        
    }
}

let classB = ClassB()

struct Cat {
    var name: String
}

let car = ClassA(name: "volvo")

let cat = Cat(name: "barsik")

enum Optional<T> {
    case some(T)
    case none
}

let optionalA: String = ""


func doSometihing() {
    let a = true
    let b = false
    guard a == b else {
        return
    }
    print(optionalA)
}

/// MARK: - Lesson 2

struct Person {
    var name: String?
    init(name: String) { self.name = name }
//    var apartment: Apartment?
//    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
//    var tenant: Person?
//    deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

let unit5A = unit4A
if unit4A === unit5A {
    print("Equal")
}

//: [Next](@next)
