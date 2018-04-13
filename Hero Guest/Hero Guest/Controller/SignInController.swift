//
//  SignInController.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/12/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

class SignInController: UIViewController {
    
    private let mailTextFieldIdentifier = "mailTextField"
    private let passwordTextFieldIdentifier = "passwordTextField"
    
    private var isMailTextFieldEmpty = true
    private var isPasswordTextFieldEmpty = true
    
    // MARK: - Elementos de UI
    
    lazy var mailTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "mail_icon"), unactiveIconImage: #imageLiteral(resourceName: "mail_icon_gray"), placeholder: "Correo", keyboardType: UIKeyboardType.emailAddress)
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.identifier = mailTextFieldIdentifier
        textFieldView.delegate = self
        
        return textFieldView
    }()
    
    lazy var passwordTextFieldView: CustomTextFieldView = {
        let textFieldView = CustomTextFieldView(iconImage: #imageLiteral(resourceName: "lock_icon"), unactiveIconImage: #imageLiteral(resourceName: "lock_icon_gray"), placeholder: "Correo", isSecureTextEntity: true)
        
        // Configurar textFieldView
        textFieldView.translatesAutoresizingMaskIntoConstraints = false
        textFieldView.identifier = passwordTextFieldIdentifier
        textFieldView.delegate = self
        
        return textFieldView
    }()
    
    lazy var textFieldsStackView: UIStackView = {
        let stackView = UIStackView()
        
        // Configurar stackView
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        
        // Configurar imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.image = #imageLiteral(resourceName: "littleman_logo")
        
        return imageView
    }()
    
    lazy var recoverPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Configurar boton
        button.setTitle("¿Olvidaste tu contraseña?", for: .normal)
        button.setTitleColor(APP_GRAY_COLOR, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Configurar botón
        button.setTitle("Iniciar sesión", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 22
        
        // Configurar colores
        button.setTitleColor(APP_SECONDARY_COLOR, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        
        button.backgroundColor = APP_GRAY_COLOR
        
        button.isEnabled = false
        
        return button
    }()
    
    lazy var moreInfoButton: UIButton = {
        let button = UIButton(type: .system)
        
        // Configurar botón
        button.setTitle("Conoce más de Hero Guest", for: .normal)
        button.setTitleColor(APP_MAIN_COLOR, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    // MARK: - ViewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar vista
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        
        // Configurar botón
        signInButton.addTarget(self, action: #selector(self.signInButtonPressed), for: .touchUpInside)
        
        // Configurar vistas
        view.addSubview(textFieldsStackView)
        view.addSubview(logoImageView)
        view.addSubview(recoverPasswordButton)
        view.addSubview(signInButton)
        view.addSubview(moreInfoButton)
        
        textFieldsStackView.addArrangedSubview(mailTextFieldView)
        textFieldsStackView.addArrangedSubview(passwordTextFieldView)
        
        // Configurar layout del stackView
        NSLayoutConstraint.activate([
            textFieldsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFieldsStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configurar layout de los textFields
        NSLayoutConstraint.activate([
            mailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            mailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            mailTextFieldView.heightAnchor.constraint(equalToConstant: 60)
        ])

        NSLayoutConstraint.activate([
            passwordTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            passwordTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            passwordTextFieldView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Configurar layout de logoImageView
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            logoImageView.bottomAnchor.constraint(equalTo: textFieldsStackView.topAnchor, constant: 10),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
        
        // Configurar layout del botón para iniciar sesión
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 90),
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
        
        // Configurar layout del botón para recuperar contraseña
        NSLayoutConstraint.activate([
            recoverPasswordButton.topAnchor.constraint(equalTo: textFieldsStackView.bottomAnchor, constant: 25),
            recoverPasswordButton.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: -25),
            recoverPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Configurar layout del botón para obtener más información
        NSLayoutConstraint.activate([
            moreInfoButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 25),
            moreInfoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            moreInfoButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: - ViewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        // Observar notificaciones del teclado
        registerForKeyboardNotifications()
    }
    
    // MARK: - ViewWillDisappear
    
    override func viewWillDisappear(_ animated: Bool) {
        deregisterFromKeyboardNotifications()
    }
    
    // MARK: - Iniciar sesión
    @objc func signInButtonPressed() {
        print("Ok")
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController()!
        present(viewController, animated: false, completion: nil)
    }
    
}

extension SignInController {
    
    // Observar cuando el teclado aparece o desaparece
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    // Dejar de observar notificaciones del teclado
    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    // Responder a la notificación del teclado
    @objc func keyboardWillShow(notification: Notification) {
        // Centrar las entradas de texto y dejar visible el botón para recuperar la contraseña
        let keyboardHeight = getKeyboardHeight(notification: notification) - textFieldsStackView.frame.height - signInButton.frame.height + (recoverPasswordButton.frame.height/2)
        
        // Animar view
        UIView.animate(withDuration: 0.1) {
            self.view.frame = CGRect(x: 0, y: -keyboardHeight, width: self.view.frame.width, height: self.view.frame.height)
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        // Animar view
        UIView.animate(withDuration: 0.1) {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.view.layoutIfNeeded()
        }
    }
    
    // Calcular el alto del teclado usando la notificación
    func getKeyboardHeight(notification: Notification) -> CGFloat {
        guard let userInfo = notification.userInfo else {
            return 0
        }
        guard let keyboardSize = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return 0
        }
        return keyboardSize.height
    }
    
}

extension SignInController {
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        _ = mailTextFieldView.resignFirstResponder()
        _ = passwordTextFieldView.resignFirstResponder()
    }
    
}

extension SignInController: CustomTextFieldViewDelegate {
    
    // MARK: - CustomTextFieldViewDelegate
    
    func textFieldEditingDidChange(_ customTextFieldView: CustomTextFieldView) {
        if customTextFieldView.identifier == mailTextFieldIdentifier {
            // Actualizar el estado del
            isMailTextFieldEmpty = customTextFieldView.isTextEmpty
        } else if customTextFieldView.identifier == passwordTextFieldIdentifier {
            // Actualizar el estado del textField
            isPasswordTextFieldEmpty = customTextFieldView.isTextEmpty
        }
        
        // Actualizar el estado del botón
        if !isMailTextFieldEmpty && !isPasswordTextFieldEmpty {
            signInButton.isEnabled = true
            signInButton.backgroundColor = APP_MAIN_COLOR
        } else {
            signInButton.isEnabled = false
            signInButton.backgroundColor = APP_GRAY_COLOR
        }
    }
    
}
