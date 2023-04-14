//
//  main.swift
//  homework-1
//
//  Created by Александр Платонов on 11.04.2023.
//

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
    """
    Марка: \(manufacturer)
    Модель: \(model)
    Тип кузова: \(body.rawValue)
    Год выпуска: \(yearOfIssue?.description ?? "-")
    \(carNumber != nil ? "Гос.номер: \(carNumber ?? "")" : "")
    """
    }
}

var cars: [Car] = [
    Car(manufacturer: "Toyota", model: "Corolla", body: .sedan, yearOfIssue: 2003, carNumber: "Л456ОГ45"),
    Car(manufacturer: "Toyota", model: "Celica", body: .coupe, yearOfIssue: 2000, carNumber: nil),
    Car(manufacturer: "Ford", model: "Raptor", body: .pickup, yearOfIssue: nil, carNumber: nil)
]

enum mainMenu: Int, CaseIterable, CustomStringConvertible {
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

func showMainMenu () -> mainMenu {
    while true {
        mainMenu.allCases.forEach { print($0) }
        let string = readLine()
        if let intDigit = Int(string ?? ""),
           let digit = mainMenu(rawValue: intDigit) {
            return digit
        }
    }
}

func addNewCar() -> Car {
    let manufacturer = requiredField(representation: "Марка авто:")
    let model = requiredField(representation: "Модель:")
    let body = bodyList()
    let year: Int?
    if let strYear = optionalField(representation: "Год выпуска:") {
        year = Int(strYear)
    } else {
        year = nil
    }
    let number = optionalField(representation: "Гос.номер:")
    return Car (manufacturer: manufacturer, model: model, body: body, yearOfIssue: year, carNumber: number)
}

func requiredField(representation: String) -> String {
    while true {
        print(representation)
        if let string = readLine(), !string.isEmpty {
            return string
        }
        print("Поле обязательно к заполнению")
    }
}

func optionalField(representation: String) -> String? {
    print(representation)
    let result = readLine()
    return result?.isEmpty ?? true ? nil : result
}

func bodyList() -> Car.Body {
    var result = "Выберите тип кузова из списка:"
    var bodyString: String
    var index = 0
    Car.Body.allCases.enumerated().map {index, body in result += "\n\(index + 1) - \(body.rawValue)"}
    repeat {
        bodyString = requiredField(representation: result)
        index = Int(bodyString) ?? 0
    } while index > Car.Body.allCases.count || index <= 0
    return Car.Body.allCases[index - 1]
}

func showBodyList(cars: [Car]) {
    cars.forEach { print($0, "\n")}
}

func filterBody() {
    let body = bodyList()
    let filteredCars = cars.filter { $0.body == body }
    showBodyList(cars: filteredCars)
}

func startApp() {
    while true {
        switch showMainMenu() {
        case .addNewCar: cars.append(addNewCar())
        case .showBodyList: showBodyList(cars: cars)
        case .filterBody: filterBody()
        case .exit: return
        }
    }
}

startApp()


