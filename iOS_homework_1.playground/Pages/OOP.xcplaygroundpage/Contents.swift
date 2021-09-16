import Foundation

class Animal {
    
    var name: String
    var age: Int
    
    func doVoice() {
        print("Голос!..")
    }
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        }
}

class Dog: Animal {
    
    private var feature: String = "Hyperactive"
    
    override func doVoice() {
        print("Гав!..")
    }
    
    func printFeature() {
        print(self.feature)
    }
}

class Cat: Animal {
    
    private var feature: String = "Lazy"
    
    override func doVoice() {
        print("Мяу!..")
    }
    
    func printFeature() {
        print(self.feature)
    }
}

var dog: Dog = Dog(name: "Барбос", age: 3)
dog.doVoice()
dog.printFeature()

var cat: Cat = Cat(name: "Барсик", age: 2)
cat.doVoice()
cat.printFeature()

