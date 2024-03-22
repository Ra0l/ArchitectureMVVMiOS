//
//  ViewController.swift
//  ArchitectureMVVM
//
//  Created by Raul Kevin Aliaga Shapiama on 3/22/24.
//

import UIKit
import Combine

class LoginView: UIViewController {
    
    let loginViewModel = LoginViewModel(apiClient: APIClient())
    var cancellables = Set<AnyCancellable>()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var loginButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Login"
        configuration.subtitle = "Ingresar"
        configuration.image = UIImage(systemName: "lock")
        
        let button = UIButton(configuration: configuration, primaryAction: UIAction(handler: { [weak self] action in
            self?.startlogin()
        }))
        button.translatesAutoresizingMaskIntoConstraints = false
        button.configuration = configuration
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        createBindingViewWithViewModel()
        
        [emailTextField, passwordTextField, loginButton, errorLabel].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            emailTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -20),
            
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            passwordTextField.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -20),
            
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20)
                                    ])
    }


    private func startlogin() {
        loginViewModel.userLogin(email: emailTextField.text?.lowercased() ?? "", password: passwordTextField.text?.lowercased() ?? "")
    }
    
    func createBindingViewWithViewModel() {
        emailTextField.textPublisher
            .assign(to: \LoginViewModel.email,
                                            on: loginViewModel)
            .store(in: &cancellables)
        
        passwordTextField.textPublisher
            .assign(to: \LoginViewModel.password,
                                               on: loginViewModel)
            .store(in: &cancellables)
        
        loginViewModel.$isEnable.assign(to: \.isEnabled, on: loginButton).store(in: &cancellables)
        
        loginViewModel.$showLoading.assign(to: \.configuration!.showsActivityIndicator, on: loginButton).store(in: &cancellables)
        
        loginViewModel.$errorMessage
            .assign(to: \UILabel.text!, on: errorLabel)
            .store(in: &cancellables)
        
        loginViewModel.$userModel.sink { [weak self] _ in
            print("Success, navigaye to home view controller")
            let homeView = HomeView()
            self?.present(homeView, animated: true)
        }.store(in: &cancellables)

    }
}

extension UITextField {
    var textPublisher: AnyPublisher<String, Never> {
        return NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: nil)
            .map { notification in
                return (notification.object as? UITextField)?.text ?? ""
            }
            .eraseToAnyPublisher()
    }
}
