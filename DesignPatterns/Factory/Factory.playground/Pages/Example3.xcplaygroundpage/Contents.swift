import XCTest

protocol ProjecorFactory {
    
    func createProjector() -> Projector
    func syncedProjector(with projector: Projector) -> Projector
}

extension ProjecorFactory {
    // Базовая реализация ProjectFactory
    func syncedProjector(with projector: Projector) -> Projector {
        // Каждый экземпляр создает собственный проектор
        let newProjector = createProjector()
        // Синхронизация с новым проектором
        newProjector.sync(with: projector)
        
        return newProjector
    }
}

// Projector interface
protocol Projector {
    
    var currentPage: Int { get }
    
    func present(info: String)
    func sync(with projector: Projector)
    func update(with page: Int)
}

extension Projector {
    // Базовая реализация методов Projector
    func sync(with projector: Projector) {
        projector.update(with: currentPage)
    }
}

class WifiFactory: ProjecorFactory {
    
    func createProjector() -> Projector {
        return WifiProjector()
    }
}

class BluetoothFactory: ProjecorFactory {
    
    func createProjector() -> Projector {
        BluetoothProjector()
    }
}

class WifiProjector: Projector {
    
    var currentPage = 0
    
    func present(info: String) {
        print("Info is presented over Wifi: \(info)")
    }
    
    func update(with page: Int) {
        // прокрутка страницы через соединение WiFi
        currentPage = page
    }
}

class BluetoothProjector: Projector {
    
    var currentPage = 0
    
    func present(info: String) {
        print("Info is presented over Bluetooth: \(info)")
    }
    
    func update(with page: Int) {
        // прокрутка страницы через соединение Bluetooth
        currentPage = page
    }
}

class ClientCode {
    
    private var currentProjector: Projector?
    
    func present(info: String, with factory: ProjecorFactory) {
        
        // Чекаем присутствует ли проектор в клиентском коде,
        // если нет, то создаем новый проектор через фабрику
        // и вызываем метод present у созданного проектора
        guard let projector = currentProjector else {
            
            let projector = factory.createProjector()
            projector.present(info: info)
            self.currentProjector = projector
            return
        }
        
        // Код клиента уже имеет проектор. Синхронизируем страницы
        // старого проектора с новым.
        self.currentProjector = factory.syncedProjector(with: projector)
        self.currentProjector?.present(info: info)
    }
}

class ProjectorFactoryTests: XCTestCase {
    
    func test_Projector_Factory_Method() {
        let info = "Very important info of the presentation"
        let clientCode = ClientCode()
        
        // Презентация информации через WiFi
        clientCode.present(info: info, with: WifiFactory())
        
        // Презентация информации через Bluetooth
        clientCode.present(info: info, with: BluetoothFactory())
    }
}

ProjectorFactoryTests.defaultTestSuite.run()

/*
 Консоль
 Info is presented over Wifi: Very important info of the presentation
 Info is presented over Bluetooth: Very important info of the presentation
 */
