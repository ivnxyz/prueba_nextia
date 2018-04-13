//
//  CustomTextFieldView.swift
//  Hero Guest
//
//  Created by Iván Martínez on 4/12/18.
//  Copyright © 2018 Iván Martínez. All rights reserved.
//

import UIKit

class CustomTextFieldView: UIView {
    
    // Propiedades
    private let iconImageViewSize: CGFloat = 25
    private let iconImage: UIImage
    private let unactiveIconImage: UIImage

    // Crear textField
    lazy var textField: SignInTextField = {
        let textField = SignInTextField()
        
        // Configurar textField
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    // Crear imagen acompañando al textField
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        
        // Configurar imageView
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Init
    
    private init(frame: CGRect, iconImage: UIImage, unactiveIconImage: UIImage) {
        self.iconImage = iconImage
        self.unactiveIconImage = unactiveIconImage
        super.init(frame: frame)
    }
    
    // Inicializar con un frame opcional
    convenience init(frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0), iconImage: UIImage, unactiveIconImage: UIImage,placeholder: String) {
        self.init(frame: frame, iconImage: iconImage, unactiveIconImage: unactiveIconImage)
        
        // Configurar valores
        textField.placeholder = placeholder
        iconImageView.image = unactiveIconImage
        
        // Colocar vistas
        addSubview(textField)
        addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: iconImageViewSize),
            iconImageView.widthAnchor.constraint(equalToConstant: iconImageViewSize),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: topAnchor),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor),
            textField.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 16)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
