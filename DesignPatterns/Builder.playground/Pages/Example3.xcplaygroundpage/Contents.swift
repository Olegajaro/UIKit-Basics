import XCTest
import Foundation

protocol DomainModel {
    // Протокол группирует модели предметной области в общий интерфейс
}

private struct User: DomainModel {
    let id: Int
    let age: Int
    let email: String
}

class BaseQueryBuilder<Model: DomainModel> {
    typealias Predicate = (Model) -> (Bool)
    
    func limit(_ limit: Int) -> BaseQueryBuilder<Model> {
        return self
    }
    
    func filter(_ predicate: @escaping Predicate) -> BaseQueryBuilder<Model> {
        return self
    }
    
    func fetch() -> [Model] {
        preconditionFailure("Should be overriden in subclasses.")
    }
}

class RealmQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {
    
    enum Query {
        case filter(Predicate)
        case limit(Int)
        /// ...
    }
    
    fileprivate var operations = [Query]()
    
    @discardableResult
    override func limit(_ limit: Int) -> RealmQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }
    
    @discardableResult
    override func filter(
        _ predicate: @escaping RealmQueryBuilder<Model>.Predicate
    ) -> BaseQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }
    
    override func fetch() -> [Model] {
        print("RealmQueryBuilder: Initializing RealmProvider with \(operations.count) operations:")
        return RealmProvider().fetch(operations)
    }
}

class CoreDataQueryBuilder<Model: DomainModel>: BaseQueryBuilder<Model> {
    
    enum Query {
        case filter(Predicate)
        case limit(Int)
        case includesPropertyValues(Bool)
        /// ...
    }
    
    fileprivate var operations = [Query]()
    
    override func limit(_ limit: Int) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.limit(limit))
        return self
    }
    
    override func filter(
        _ predicate: @escaping CoreDataQueryBuilder<Model>.Predicate
    ) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.filter(predicate))
        return self
    }
    
    func includesPropertyValues(_ toggle: Bool) -> CoreDataQueryBuilder<Model> {
        operations.append(Query.includesPropertyValues(toggle))
        return self
    }
    
    override func fetch() -> [Model] {
        print("CoreDataQueryBuilder: Initializing CoreDataProvider with \(operations.count) operations.")
        return CoreDataProvider().fetch(operations)
    }
}

/// Дата провайдеры содержат логику получения моделей.
/// Строители накапливают операции, а затем обновляют провайдеров для получения данных.
class RealmProvider {
    
    func fetch<Model: DomainModel>(_ operations: [RealmQueryBuilder<Model>.Query]) -> [Model] {
        
        print("RealmProvider: Retrieving data from Realm...")
        
        for item in operations {
            switch item {
            case .filter(_):
                print("RealmProvider: executing the 'filter' operation.")
                // Use Realm instance to filter results.
                break
            case .limit(_):
                print("RealmProvider: executing the 'limit' operation.")
                // Use Realm instance to limit results.
                break
            }
        }
        
        // Return results from Realm
        return []
    }
}

class CoreDataProvider {
    
    func fetch<Model: DomainModel>(
        _ operations: [CoreDataQueryBuilder<Model>.Query]
    ) -> [Model] {
        
        // Create a NSFetchRequest
        
        print("CoreDataProvider: Retrieving data from CoreData...")
        
        for item in operations {
            switch item {
            case .filter(_):
                print("CoreDataProvider: executing the 'filter' operation.")
                // Set a 'predicate' for a NSFetchRequest.
                break
            case .limit(_):
                print("CoreDataProvider: executing the 'limit' operation.")
                // Set a 'fetchLimit' for a NSFetchRequest.
                break
            case .includesPropertyValues(_):
                print("CoreDataProvider: executing the 'includesPropertyValues' operation.")
                // Set an 'includesPropertyValues' for a NSFetchRequest.
                break
            }
        }
        
        // Execute a NSFetchRequest and return results.
        return []
    }
}

class BuilderTests: XCTestCase {
    
    func test_Builder() {
        print("Client: Start fetching data from Realm")
        clientCode(builder: RealmQueryBuilder<User>())
        
        print()
        
        print("Client: Start fetching data from CoreData")
        clientCode(builder: CoreDataQueryBuilder<User>())
    }
    
    private func clientCode(builder: BaseQueryBuilder<User>) {
        
        let results = builder.filter { $0.age < 20 }.limit(1).fetch()
        
        print("Client: I have fetched: " + String(results.count) + " records.")
    }
}

BuilderTests.defaultTestSuite.run()
