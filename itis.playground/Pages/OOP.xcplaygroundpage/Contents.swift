import UIKit

class Transport {
    var fuelSupply: Double
    private var yearOfIssue: Int
    var license: Bool = false
    
    init(fuelSupply: Double, yearOfIssue:Int) {
        self.fuelSupply = fuelSupply
        self.yearOfIssue = yearOfIssue
    }
    
    func movement() {
        print("Движемся!")
    }
    
    func getYearOfIssue() -> Int {
        return self.yearOfIssue
    }
}

class Cars: Transport {
    var type: String
    
    init(fuelSupply: Double, yearOfIssue:Int, type: String) {
        self.type = type
        super.init(fuelSupply: fuelSupply, yearOfIssue: yearOfIssue)
    }
    
    override func movement() {
        print("Поехали!")
    }
}

class Planes: Transport {
    var aoutopilot: Bool = false
    
    override func movement() {
        print("Полетели!")
    }
}

class LicenseIssuance {
    func issue(transport: Transport) {
        transport.license = true
    }
}

