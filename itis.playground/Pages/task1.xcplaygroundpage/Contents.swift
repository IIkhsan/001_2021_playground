
import Foundation


//абстракция
protocol Phone {
    var number: Int { get }
    
    init(number: Int)
    
    func call(outputNumber: Int)
    
    func ring(inputNumber: Int)
}


//инкапсуляция
class SomePhone {
    private var year: Int
    private var company: String
    
    
    init(year: Int, company: String) {
        self.year = year
        self.company = company
    }
    
    private func openConnection() {}
    
    func call() {
        openConnection()
        print("Вызов")
    }
    
    func ring() {
        print("Звонок")
    }
}


//наследование
class Iphone: Phone {
    var number: Int
    
    required init(number: Int) {
        self.number = number
    }
    
    func call(outputNumber: Int) {
        print("Вызов по номеру\(outputNumber)")
    }
    
    func ring(inputNumber: Int) {
        print("Звонок от \(inputNumber)")
    }
}



//полиморфизм
class Iphone4s: Iphone {
    func daf() {
        print("sd")
    }
}

var iphone: Iphone = Iphone4s(number: 4)

print(iphone.self)
iphone.call(outputNumber: 1234)
