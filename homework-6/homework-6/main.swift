import Foundation


struct Car: CustomStringConvertible {
    
    let manufacturer: String
    let model: String
    let body: Body
    let yearOfIssue: Int?
    let carNumber: String?
    
    enum Body: String, CaseIterable {
        case sedan = "Седан"
        case hatchback = "Хэтчбек"
        case liftback = "Лифтбек"
        case crossover = "Кроссовер"
        case universal = "Универсал"
        case minivan = "Минивэн"
        case coupe = "Купе"
        case pickup = "Пикап"
    }
    
    var description: String {
        let number: String
        if let num = carNumber {
            number = "Гос.номер: \(num)"
        } else {
            number = ""
        }
        
        let info = """
    Марка: \(manufacturer)
    Модель: \(model)
    Тип кузова: \(body.rawValue)
    Год выпуска: \(yearOfIssue?.description ?? "-")
    """ + "\n\(number)"
        return info
    }
}

class CarBuilder {
    var manufacturer: String = ""
    var model: String = ""
    var body: Car.Body = .sedan
    var yearOfIssue: Int?
    var carNumber: String?
    
    func setManufacturer(_ manufacturer: String) -> CarBuilder {
        self.manufacturer = manufacturer
        return self
    }
    
    func setModel(_ model: String) -> CarBuilder {
        self.model = model
        return self
    }
    
    func setBody(_ body: Car.Body) -> CarBuilder {
        self.body = body
        return self
    }
    
    func setYearOfIssue(_ yearOfIssue: Int?) -> CarBuilder {
        self.yearOfIssue = yearOfIssue
        return self
    }
    
    func setCarNumber(_ carNumber: String?) -> CarBuilder {
        self.carNumber = carNumber
        return self
    }
    
    func build() -> Car {
        return Car(manufacturer: manufacturer, model: model, body: body, yearOfIssue: yearOfIssue, carNumber: carNumber)
    }
}

var cars: [Car] = [
    CarBuilder()
        .setManufacturer("Toyota")
        .setModel("Corolla")
        .setBody(.sedan)
        .setYearOfIssue(2003)
        .setCarNumber("Л456ОГ45")
        .build(),
    CarBuilder()
        .setManufacturer("Toyota")
        .setModel("Celica")
        .setBody(.coupe)
        .setYearOfIssue(2000)
        .build(),
    CarBuilder()
        .setManufacturer("Ford")
        .setModel("Raptor")
        .setBody(.pickup)
        .build()
]

enum MainMenu: Int, CaseIterable, CustomStringConvertible {
    case addNewCar = 1
    case showBodyList = 2
    case filterBody = 3
    case exit = 0
    
    var description: String {
        switch self {
        case .addNewCar:
            return "\(self.rawValue) - Добавить новый автомобиль"
        case .showBodyList:
            return "\(self.rawValue) - Показать список автомобилей"
        case .filterBody:
            return "\(self.rawValue) - Выбор типа кузова автомобиля"
        case .exit:
            return "\(self.rawValue) - Выход"
        }
    }
}
func showMainMenu() -> MainMenu {
    while true {
        MainMenu.allCases.forEach { print($0) }
        let string = readLine()
        if let intDigit = Int(string ?? ""),
           let digit = MainMenu(rawValue: intDigit) {
            return digit
        }
    }
}

func addNewCar() -> Car {
    let manufacturer = showRequiredField(representation: "Марка авто:")
    let model = showRequiredField(representation: "Модель:")
    let body = createBodyList()
    let year: Int?
    if let strYear = showOptionalField(representation: "Год выпуска:") {
        year = Int(strYear)
    } else {
        year = nil
    }
    let number = showOptionalField(representation: "Гос.номер:")
    return CarBuilder()
        .setManufacturer(manufacturer)
        .setModel(model)
        .setBody(body)
        .setYearOfIssue(year)
        .setCarNumber(number)
        .build()
}


func showRequiredField(representation: String) -> String {
    while true {
        print(representation)
        if let string = readLine(), !string.isEmpty {
            return string
        }
        print("Поле обязательно к заполнению")
    }
}

func showOptionalField(representation: String) -> String? {
    print(representation)
    guard let result = readLine(), !result.isEmpty else {
        return nil
    }
    return result
}

func createBodyList() -> Car.Body {
    var result = "Выберите тип кузова из списка:"
    var bodyString: String
    var index = 0
    Car.Body.allCases.enumerated().map { index, body in result += "\n\(index + 1) - \(body.rawValue)" }
    repeat {
        bodyString = showRequiredField(representation: result)
        index = Int(bodyString) ?? 0
    } while index > Car.Body.allCases.count || index <= 0
    return Car.Body.allCases[index - 1]
}

func showBodyList(cars: [Car]) {
    cars.forEach { print($0, "\n") }
}

func filterBody() {
    let body = createBodyList()
    let filteredCars = cars.filter { $0.body == body }
    showBodyList(cars: filteredCars)
}

func startApp() {
    while true {
        switch showMainMenu() {
        case .addNewCar:
            cars.append(addNewCar())
        case .showBodyList:
            showBodyList(cars: cars)
        case .filterBody:
            filterBody()
        case .exit:
            return
        }
    }
}

startApp()


