import Foundation
import XCTest

// Паттерн абстрактная фабрика

// Назначение: Предоставляет интерфейс для создания семейств связанных или
// зависимых объектов без привязки к их конкретным классам.

// Каждый отдельный продукт семейства продуктов должен иметь базовый интерфейс.
// Все вариации продукта должны реализовывать этот интерфейс.
protocol AbstractProductA {
    
    func usefulFunctionA() -> String
}

// Конкретные продукты будут создаваться соответствующими конкретными фабриками.
class ConcreteProductA1: AbstractProductA {
    
    func usefulFunctionA() -> String {
        "The result of the product A1."
    }
}

class ConcreteProductA2: AbstractProductA {
    func usefulFunctionA() -> String {
        "The result of the product A2."
    }
}

// Базовый интерфейс другого продукта. Все продукты могут взаимодействовать
// друг с другом, но правильно взаимодействие возможно только между продуктами
// одной и той же конкретной вариации.
protocol AbstractProductB {
    
    // Продукт В способен работать самостоятельно
    func usefulFunctionB() -> String
    
    // А так же может взаимодействовать с Продуктами A той же вариации.
    ///
    // Абстрактная фабрика гарантирует, что все продукты, которые она создает,
    // имеют одинаковую вариацию и, следовательно, совместимы.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String
}

// Конкретные продукты так же создаются соответствующими конкретными фабриками.
class ConcreteProductB1: AbstractProductB {
    
    func usefulFunctionB() -> String {
        "The result of the product B1."
    }
    
    /// Продукт В1 может корректно работать только с продуктом А1. Тем не менее,
    /// он принимает любой экземпляр Абстрактного Продукта А в качестве аргумента.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B1 collaborating with the (\(result))"
    }
}

class ConcreteProductB2: AbstractProductB {
    
    func usefulFunctionB() -> String {
        "The result of the product B2."
    }
    
    /// Продукт В2 может корректно работать только с продуктом А2. Тем не менее,
    /// он принимает любой экземпляр Абстрактного Продукта А в качестве аргумента.
    func anotherUsefulFunctionB(collaborator: AbstractProductA) -> String {
        let result = collaborator.usefulFunctionA()
        return "The result of the B2 collaborating with the (\(result))"
    }
}

/// Интерфейс Абстрактной Фабрики объявляет набор методов, которые возвращают
/// различные абстрактные продукты. Эти продукты называются семейством и связаны
/// темой или концепцией высокого уровня. Продукты одного семейства обычно могут
/// взаимодействовать между собой. Семейство продуктов может иметь несколько
/// вариаций, но продукты одной вариации несовместимы с продуктами другой.
protocol AbstractFactory {
    
    func createProductA() -> AbstractProductA
    func createProductB() -> AbstractProductB
}

/// Конкретная Фабрика производит семейство продуктов одной вариации. Фабрика
/// гарантирует совместимость полученных продуктов. Сигнатуры методов Конкретной Фабрики
/// возвращают абстрактный продукт, а внутри метода создается экземпляр конкретного продукта.
class ConcreteFactory1: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA1()
    }
    
    func createProductB() -> AbstractProductB {
        return ConcreteProductB1()
    }
}

/// Каждая Конкретная Фабрика имеет соответствующую вариацию продукта.
class ConcreteFactory2: AbstractFactory {
    
    func createProductA() -> AbstractProductA {
        return ConcreteProductA2()
    }
    
    func createProductB() -> AbstractProductB {
        return ConcreteProductB2()
    }
}

/// Клиентский код работает с фабриками и продуктами только через абстрактные типы:
/// Абстрактная Фабрика и Абстрактный Продукт. Это позволяет передавать
/// любой подкласс фабрики или продукта клиентскому коду, не нарушая его.
class Client {
    static func someClientCode(factory: AbstractFactory) {
        let productA = factory.createProductA()
        let productB = factory.createProductB()
        
        print(productB.usefulFunctionB())
        print(productB.anotherUsefulFunctionB(collaborator: productA))
    }
}

class AbstractFactoryTests: XCTestCase {
    
    func test_Abstract_Factory() {
        
        // Клиентский код может работать с любым конкретным классом фабрики.
        
        print("Client: Testing client code with the first factory type:")
        Client.someClientCode(factory: ConcreteFactory1())
        
        print("Client: Testing the same client code with the second factory type:")
        Client.someClientCode(factory: ConcreteFactory2())
    }
}

AbstractFactoryTests.defaultTestSuite.run()

/*
 Консоль
 Client: Testing client code with the first factory type:
 The result of the product B1.
 The result of the B1 collaborating with the (The result of the product A1.)
 
 Client: Testing the same client code with the second factory type:
 The result of the product B2.
 The result of the B2 collaborating with the (The result of the product A2.)
 */
