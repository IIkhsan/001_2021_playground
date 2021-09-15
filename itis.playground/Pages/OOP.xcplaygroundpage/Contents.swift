//: [Previous](@previous)

import Foundation

class Animal {
    func voice() {
        print("Голос!")
    }
}

// Наследование. Используем свойства и методы из класса 'Animal'
class Cat: Animal {
    private let feature: String = "gentle" // Инкапсуляция. Убираем возможность смены свойства
    
    override func voice() {
        print("Мяу!")
    }
    
    func printFeauture() {
        print(self.feature)
    }
}

class Dog: Animal {
    private let feature: String = "active"
    
    override func voice() {
        print("Гав")
    }
    
    func printFeauture() {
        print(self.feature)
    }
}

// Полиморфизм. Работаем с несколькими типами так, будто это один и тот же тип

var cat: Cat = Cat()
cat.voice()
cat.printFeauture()

var dog: Animal = Dog()
dog.voice()

var newCat: Cat = Cat()
newCat.printFeauture()
//: [Next](@next)
