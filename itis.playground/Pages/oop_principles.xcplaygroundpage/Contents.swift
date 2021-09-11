//: [Previous](@previous)

import Foundation

/// MARK: - Abstraction

protocol AbstractPhone {
    
    var year: Int { get set }
    var companyName: String { get }
    var modelID: Int { get }
    
    func call(outputNumber: Int) -> Void
    func ring(inputNumber: Int) -> Void
}

/// MARK: - Incapsulation

class SomePhone {
    
    private let releaseYear: Int
    private let companyName: String
    
    init(in releaseYear: Int, from companyName: String) {
        self.releaseYear = releaseYear
        self.companyName = companyName
    }
    
    open func openConnection() {
//        findComutator...
//        openNewConnection...
    }
    
    func call() {
        openConnection()
        print("Вызываю номер")
    }

    func ring() {
        print("Дзынь-дзынь")
    }
}

/// MARK: - Inheritance

protocol WirelessPhone: AbstractPhone {

    var resourceOfWorkInHours: Int { get set }
}

class CellPhone: WirelessPhone {
    
    var year: Int
    var companyName: String
    var modelID: Int
    var resourceOfWorkInHours: Int
    
    init(year: Int, companyName: String, modelID: Int, hours: Int) {
        self.year = year
        self.resourceOfWorkInHours = hours
        self.companyName = companyName
        self.modelID = modelID
    }
    
    func call(outputNumber: Int) {
        print("Вызываю номер " + String(outputNumber))
    }
    
    func ring(inputNumber: Int) {
        print("Вам звонит абонент " + String(inputNumber))
    }
}

class Smartphone: CellPhone {
    
    let operationSystem: String
    private var blockedNumbers: [Int] = []
    
    init(year: Int, companyName: String, modelID: Int, hours: Int, operationSystem: String) {
        self.operationSystem = operationSystem
        super.init(year: year, companyName: companyName, modelID: modelID, hours: hours)
    }
    
    override func ring(inputNumber: Int) {
        super.ring(inputNumber: inputNumber)
        if blockedNumbers.contains(inputNumber) {
            print("Этот номер находится в черном списке")
        }
    }
    
    func install(program: String) {
        print("Устанавливаю " + program + " для " + operationSystem)
    }
}

/// MARK: - Polymorphism

extension CellPhone: CustomStringConvertible {
    
    @objc var description: String {
        return "Телефон \(modelID) (\(companyName), \(year))"
    }
}

extension Smartphone {
    
    override var description: String {
        return "Смартфон \(modelID) (\(companyName), \(year))"
    }
}

protocol CanBlockNumber {
    
    func blockNumber(_ number: Int)
}

extension Smartphone: CanBlockNumber {
    
    func blockNumber(_ number: Int) {
        blockedNumbers.append(number)
    }
}

class User {
    
    private let name: String
    private var phones: [AbstractPhone] = []
    
    init(name: String) {
        self.name = name
    }
    
    func getPhones() -> [AbstractPhone] {
        return self.phones
    }
    
    func addPhone(phone: AbstractPhone) {
        phones.append(phone)
    }
}

let firstPhone = CellPhone(year: 2010, companyName: "Nokia", modelID: 3310, hours: 999999)
let secondPhone = Smartphone(year: 2020, companyName: "Apple", modelID: 2111, hours: 9999, operationSystem: "iOS")
let user = User(name: "Ваня")
user.addPhone(phone: firstPhone)
user.addPhone(phone: secondPhone)

for phone in user.getPhones() {
    print(phone, terminator: ": ")
    if let phone = phone as? CanBlockNumber {
        phone.blockNumber(89997777777)
    }
    phone.ring(inputNumber: 89997777777)
}

//: [Next](@next)
