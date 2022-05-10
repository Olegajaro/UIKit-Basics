import XCTest
import Foundation
// Назначение: Определяет общий интерфейс для создания объектов в суперклассе,
// позволяя подклассам изменять тип создаваемых объектов

// Протокол создатель объявляет фабричный метод, который должен возвращать
// объект класса Product. Классы подписанные под данный протокол
// предоставляют реализацию этого метода.
protocol Creator {
    
    // Создатель может обеспечить реализацию фабричного метода по умолчанию
    func factoryMethod() -> Product
    
    // Создатель обычно содержит некоторую базовую логику,
    // которая основана на объектах Продуктов, возвращаемых фабричным методом.
    // Подклассы могут изменять эту логику, переопределяя фабричный метод и
    // возвращая из него другой тип продукта.
    func someOperation() -> String
}

// Расширение протокола реализует базовое поведения Создателя.
// Оно может так же быть переопределено.
extension Creator {
    func someOperation() -> String {
        // Создаем продукт с помощью фабричного метода
        let product = factoryMethod()
        
        // Работа с продуктом
        return "Creator: The same creator's code has just worked with " + product.operation()
    }
}

// Конкретные создатели переопределяют фабричный метод для того,
// чтобы изменить тип результирующего продукта.
class ConcreteCreator1: Creator {
    func factoryMethod() -> Product {
        return ConcreteProduct1()
    }
}

class ConcreteCreator2: Creator {
    func factoryMethod() -> Product {
        return ConcreteProduct2()
    }
}

// Протокол Product объявляет операции, которые должны выполнять
// все конкретные продукты.
protocol Product {
    func operation() -> String
}

// Конкретные продукты предоставляют различные реализации протокола Product
class ConcreteProduct1: Product {
    func operation() -> String {
        return "{Result of the ConcreteProduct1}"
    }
}

class ConcreteProduct2: Product {
    func operation() -> String {
        return "{Result of the ConcreteProduct2}"
    }
}

// Клиентский код работает с экземпляром конкретного создателя,
// но через его базовый протокол. Пока клиент продолжает работать с создатеелем
// через базовый протокол, вы можете передать ему любой подкласс создателя.
class Client {
    static func someClientCode(creator: Creator) {
        print("Client: I'm not aware of the creator's class, but it still works.\n" + creator.someOperation())
    }
}

class FactoryMethodConceptual: XCTestCase {
    
    func test_Factory_Method_Conceptual() {
        
        // Приложение выбирает тип создателя в зависимости от конфигурации
        // или среды
        
        print("App: Launched with the ConcreteCreator1.")
        Client.someClientCode(creator: ConcreteCreator1())
        
        print("\nApp: Launched with the ConcreteCreator2.")
        Client.someClientCode(creator: ConcreteCreator2())
    }
}

FactoryMethodConceptual.defaultTestSuite.run()

/*
 Консоль
 App: Launched with the ConcreteCreator1.
 Client: I'm not aware of the creator's class, but it still works.
 Creator: The same creator's code has just worked with {Result of the ConcreteProduct1}

 App: Launched with the ConcreteCreator2.
 Client: I'm not aware of the creator's class, but it still works.
 Creator: The same creator's code has just worked with {Result of the ConcreteProduct2}
 */
