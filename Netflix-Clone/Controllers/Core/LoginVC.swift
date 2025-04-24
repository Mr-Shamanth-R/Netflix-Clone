//
//  LoginVC.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 21/04/25.
//

import UIKit
import GoogleSignIn

class LoginVC: UIViewController {
    
    private let backgroundImage: UIImageView = {
       let image = UIImageView()
        image.image = UIImage(named: "splashScreen")
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let signInButton: UIButton = {
       let button = UIButton()
        button.backgroundColor = UIColor(_colorLiteralRed: 229/255, green: 9/255, blue: 20/255, alpha: 1)
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpLoginView()
        setUpSignIn()
    }
    
    private func setUpLoginView() {
        view.addSubview(backgroundImage)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100),
            signInButton.widthAnchor.constraint(equalToConstant: 200),
            signInButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setUpSignIn() {
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        // Auto-login if already signed in
        if GoogleSignInManager.shared.isLoggedIn() {
            navigateToTabBar()
        }
    }

    @objc private func signInTapped() {
        GoogleSignInManager.shared.signIn(presentingVC: self) { [weak self] success in
            if success {
                self?.navigateToTabBar()
            } else {
                let alert = UIAlertController(title: "Error", message: "Google Sign-In failed.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                self?.present(alert, animated: true)
            }
        }
    }

    private func navigateToTabBar() {
        DispatchQueue.main.async {
            let tabBarVC = MainTabBarVC()
            tabBarVC.modalPresentationStyle = .fullScreen
            self.present(tabBarVC, animated: true)
        }
    }
}
