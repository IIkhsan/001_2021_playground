import Foundation

class Animal {
    
     var name: String
     var age: Int
    
    func sayHello() -> String {
        return "Hello"
    }
    
    init(name: String, age: Int) {
        self.age = age
        self.name = name
    }
    
}

class Cat: Animal {
    
    override func sayHello() -> String {
        return "Muy"
    }
}

class Dog: Animal {
    override func sayHello() -> String {
        return "Gav"
    }
}

var cat: Cat
cat = Cat.init(name: "Pushok", age: 2)

