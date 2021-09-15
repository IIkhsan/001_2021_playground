//: [Previous](@previous)

import Foundation

class Transport {
    let model: String

    init(model: String) {
        self.model = model
    }
    
    //Инкапсуляция
    func takeoff() {
        fatalError("This method can only be executed for plane")
    }
}

//Наследование
class Aircraft: Transport {
    let isBroken: Bool
    
    init(model: String, isBroken: Bool = false) {
        self.isBroken = isBroken
        
        super.init(model: model)
    }
    
    override func takeoff() {
        print("Aircraft took off")
    }
}

//Полиморфзим
class Plane: Aircraft {
    override func takeoff() {
        print("Plane took off")
    }
}

//: [Next](@next)
