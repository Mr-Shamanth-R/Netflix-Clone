//
//  LoginVC.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 21/04/25.
//

import UIKit

class LoginVC: UIViewController {
    
    private let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "splashScreen")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let signInButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let loginButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpLoginView()
    }
    
    private func setUpLoginView() {
        view.addSubview(backgroundImage)
        view.addSubview(loginButton)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            backgroundImage.widthAnchor.constraint(equalToConstant: view.frame.width + 20),
            backgroundImage.heightAnchor.constraint(equalToConstant: view.frame.height + 60),
            backgroundImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            signInButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            signInButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            loginButton.bottomAnchor.constraint(equalTo: signInButton.topAnchor, constant: 20),
            loginButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
