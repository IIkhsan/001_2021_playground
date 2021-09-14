//: [Previous](@previous)

import Foundation

var greeting = "Hello, playground"
// ---------- Абстракция ----------
protocol PhoneExample {
    var year: Int {get}
    func makeCall ()
    func receiveCall ()
}

class WirePhone: PhoneExample  {
    let year: Int
    let name: String
    
    init(year: Int, name: String) {
        self.year = year
        self.name = name
    }
    
    func makeCall () {
        print("Звоню")
    }
    func receiveCall () {
        print("Принимаю звонок")
    }
}

class SmartPhone: PhoneExample  {
    let year: Int
    let name: String
    let cpu: String
    let fastCharge: Bool
    
    init(year: Int, name: String, cpu: String, fastcharge: Bool) {
        self.year = year
        self.name = name
        self.cpu = cpu
        self.fastCharge = fastcharge
    }
    
    func makeCall () {
        print("Звоню")
    }
    func receiveCall () {
        print("Принимаю звонок")
    }
    func turnOnFastCharge (fastCharge: Bool) {
        if fastCharge == true {
            print("Быстрая зарядка включена")
        } else {
            print("Быстрая зарядка не поддерживается")
        }
        
    }
}




// ---------- Инкапсуляция ----------
class PersonalComputer {
    private let cpu: String
    private let gpu: String
    
    
    init(gpu: String, cpu: String) {
        self.cpu = cpu
        self.gpu = gpu
    }
   
    func turnOn () {
        print("ПК включен")
    }
    func turnOff () {
        print("ПК выключен")
    
    }
}




// ---------- Наследование ----------

class Transport {
    let capacity: Int
    let speed: Int
    
    init(capacity: Int, speed: Int) {
        self.capacity = capacity
        self.speed = speed
    }
    func showCapacity (capacity: Int) {
        print("Вместимость = \(capacity)")
    }
    func drive(){
        print("Вожу транспорт!")
    }
}

class Car: Transport {
    let horsePower: Int
    let country: String
    let tankVolume: Int
    
     init(capacity: Int, speed: Int, horsePower: Int, country: String, tankVolume: Int ) {
        self.horsePower = horsePower
        self.country = country
        self.tankVolume = tankVolume
        super.init(capacity: capacity, speed: speed)
    }
    
    func turnOn() {
        print("Двигатель включен!")
    }
    override func drive() {
        print("Вожу автомобиль!")
    }
}

class AirTransport: Transport {
    var maxHeigth: Int
    var engineAmount: Int
    var tankVolume: Int
    
     init(capacity: Int, speed: Int, maxHeigth: Int, engineAmount: Int, tankVolume: Int ) {
        self.maxHeigth = maxHeigth
        self.engineAmount = engineAmount
        self.tankVolume = tankVolume
        super.init(capacity: capacity, speed: speed)
    }
    func takeoff () {
        print("Взлет!")
    }
    override func drive() {
        print("Вожу воздушное транспортное средство!")
    }
}

class ElectroCar: Car {
    var batteryDistance: Int
    
    init(capacity: Int, speed: Int, horsePower: Int, tankVolume: Int,  country: String, batteryDistance: Int) {
        self.batteryDistance = batteryDistance
        super.init(capacity: capacity, speed: speed, horsePower: horsePower, country: country, tankVolume: tankVolume )
        
    }
    override func turnOn() {
        print("Баттарея включена, автопилот настроен!")
    }
    override func drive() {
        print("Вожу электрокар!")
    }
}

class Person {
    var name: String
    var age: Int
    
    init(age: Int, name: String) {
        self.age = age
        self.name = name
    }
    func driveTransport(transport: Transport) {
        transport.drive()
    }
}
let man: Person = Person(age: 21, name: "Иван")
let jeep: ElectroCar = ElectroCar(capacity: 4, speed: 260, horsePower: 249, tankVolume: 3400, country: "USA", batteryDistance: 300)
man.driveTransport(transport: jeep)
