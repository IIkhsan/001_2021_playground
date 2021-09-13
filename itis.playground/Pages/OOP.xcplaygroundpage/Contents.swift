import Foundation
//Abstraction

protocol AbstractPhone {
    func call(outputNumber: Int)
    func ring(inputNumber: Int)
}

//Encapsulation
public class SomePhone {
    private var year: Int
    private var company: String
    
    init(year: Int, company: String) {
        self.year = year
        self.company = company
    }
    
    private func openConnection() {
        //findComutator
        //openNewConnection
    }
    
    public func call() {
        openConnection();
        print("Вызываю номер")
    }
    
    public func ring() {
        print("Дзынь-дзынь")
    }
}
//Inheritance
public class CellPhone {
    var year: Int
    var hour: Int
    
    init (year: Int, hour: Int) {
        self.year = year
        self.hour = hour
    }
    
    func call(outputNumber: Int) {
        print("Вызываю номер \(outputNumber)")
    }
    
    func ring(inputNumber: Int) {
        print("Вам звонит абонент \(inputNumber)")
    }
}

public class Smartphone: CellPhone {
    private var operationSystem: String
    
    init(year: Int, hour: Int, operationSystem: String) {
        self.operationSystem = operationSystem
        super.init(year: year, hour: hour)
    }
    
    public func install(program: String) {
        print("Устанавливаю \(program) для \(operationSystem)")
    }
}
//Polymorphism
public class User {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func callAnotherUser(number: Int, phone: AbstractPhone) {
        phone.call(outputNumber: number)
    }
}

public class Phone: AbstractPhone {

    func call(outputNumber: Int) {
        print("Вызываю номер \(outputNumber)")
    }
    
    func ring(inputNumber: Int) {
        print("Телефон звонит \(inputNumber)")
    }
}

public class VideoPhone: AbstractPhone {
    
    func call(outputNumber: Int) {
        print("Подключаю видеоканал для обонента \(outputNumber)")
    }
    
    func ring(inputNumber: Int) {
        print("У вас входящий видеовызов...\(inputNumber)")
    }
}

var user = User(name: "Oleg")
var phone: AbstractPhone = Phone()
var videoPhone: AbstractPhone = VideoPhone()
user.callAnotherUser(number: 21512, phone: phone)
user.callAnotherUser(number: 51251, phone: videoPhone)

