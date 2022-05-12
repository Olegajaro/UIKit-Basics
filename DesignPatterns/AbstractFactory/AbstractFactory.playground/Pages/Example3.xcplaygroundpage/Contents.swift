import Foundation
import XCTest
import UIKit

enum AuthType {
    case login
    case signUp
}

protocol AuthView {
    
    typealias AuthAction = (AuthType) -> Void
    
    var contentView: UIView { get }
    var authHandler: AuthAction? { get set }
    
    var description: String { get }
}

class StudentSugnUpView: UIView, AuthView {
    private class StudentSignUpContentView: UIView {
        /*
         Это представление содержит ряд функций,
         доступных только при авторизации STUDENT.
         */
    }
    
    var contentView: UIView = StudentSignUpContentView()
    // Обработчик будет подключен для действий кнопок этого представления.
    var authHandler: AuthAction?
    
    override var description: String {
        return "Student-SignUp-View"
    }
}

class StudentLoginView: UIView, AuthView {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let signUpButton = UIButton()
    
    var contentView: UIView {
        return self
    }
    // Обработчик будет подключен для действий кнопок этого представления.
    var authHandler: AuthAction?
    
    override var description: String {
        return "Student-Login-View"
    }
}

class TeacherSignUpView: UIView, AuthView {
    
    class TeacherSignUpContentView: UIView {
        /*
         Этот вид содержит ряд функций,
         доступных только при авторизации TEACHER.
         */
    }
    
    var contentView: UIView = TeacherSignUpContentView()
    var authHandler: AuthAction?
    
    override var description: String {
        return "Teacher-SignUp-View"
    }
}

class TeacherLoginView: UIView, AuthView {
    
    private let emailTextField = UITextField()
    private let passwordTextField = UITextField()
    private let loginButton = UIButton()
    private let forgotPasswordButton = UIButton()
    
    var contentView: UIView {
        return self
    }
    
    var authHandler: AuthAction?
    
    override var description: String {
        return "Teacher-Login-View"
    }
}

class AuthViewController: UIViewController {
    
    fileprivate var contentView: AuthView
    
    init(contentView: AuthView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        return nil
    }
}

class StudentAuthViewController: AuthViewController {
    // Student-oriented features
}

class TeacherAuthViewController: AuthViewController {
    // Teacher-oriented features
}

protocol AuthViewFactory {
    static func authView(for type: AuthType) -> AuthView
    static func authController(for type: AuthType) -> AuthViewController
}

class StudentAuthViewFactory: AuthViewFactory {
    
    static func authView(for type: AuthType) -> AuthView {
        print("Student View has been created")
        switch type {
        case .login:
            return StudentLoginView()
        case .signUp:
            return StudentSugnUpView()
        }
    }
    
    static func authController(for type: AuthType) -> AuthViewController {
        let controller = StudentAuthViewController(contentView: authView(for: type))
        print("Student View Controller has been created")
        return controller
    }
}

class TeacherAuthViewFactory: AuthViewFactory {
    
    static func authView(for type: AuthType) -> AuthView {
        print("Teacher View has been created")
        switch type {
        case .login:
            return TeacherLoginView()
        case .signUp:
            return TeacherSignUpView()
        }
    }
    
    static func authController(for type: AuthType) -> AuthViewController {
        let controller = TeacherAuthViewController(contentView: authView(for: type))
        print("Teacher View Controller has been created")
        return controller
    }
}

class ClientCode {
    
    private var currentController: AuthViewController?
    
    private lazy var navigationController: UINavigationController = {
        guard let vc = currentController else { return UINavigationController() }
        return UINavigationController(rootViewController: vc)
    }()
    
    private let factoryType: AuthViewFactory.Type
    
    init(factoryType: AuthViewFactory.Type) {
        self.factoryType = factoryType
    }
    
    /// MARK: - Presentation
    
    func presentLogin() {
        let controller = factoryType.authController(for: .login)
        navigationController.pushViewController(controller, animated: true)
    }
    
    func presentSignUp() {
        let controller = factoryType.authController(for: .signUp)
        navigationController.pushViewController(controller, animated: true)
    }
}

class AuthViewFactoryTests: XCTestCase {
    
    func test_AuthView_Factory() {
        
        #if teacherMode
        let clientCode = ClientCode(factoryType: TeacherAuthViewFactory.self)
        #else
        let clientCode = ClientCode(factoryType: StudentAuthViewFactory.self)
        #endif
        
        // Present Login flow
        clientCode.presentLogin()
        print("Login screen has been presented")
        
        // Present SignUp flow
        clientCode.presentSignUp()
        print("Sign up screen has been presented")
    }
}

AuthViewFactoryTests.defaultTestSuite.run()

/*
 Консоль
 Student View has been created
 Student View Controller has been created
 Login screen has been presented
 
 Student View has been created
 Student View Controller has been created
 Sign up screen has been presented
 */
