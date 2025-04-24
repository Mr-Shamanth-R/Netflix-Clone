//
//  ProfileVC.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 22/04/25.
//

import UIKit
import GoogleSignIn
import SDWebImage

class ProfileVC: UIViewController {
    
    private let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = image.frame.height/2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let email: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(_colorLiteralRed: 229/255, green: 9/255, blue: 20/255, alpha: 1)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        button.layer.cornerRadius = 8
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let disclaimer: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Disclaimer: This profile information is for personalization purposes only and is not shared publicly. It helps tailor your viewing experience across the app."
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpProfileView()
        fetchProfileData()
    }
    
    private func setUpProfileView() {
        title = "Profile"
        navigationController?.navigationBar.tintColor = .white
        view.addSubview(profileImage)
        view.addSubview(userName)
        view.addSubview(email)
        view.addSubview(disclaimer)
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileImage.widthAnchor.constraint(equalToConstant: 200),
            profileImage.heightAnchor.constraint(equalToConstant: 200),
            
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20),
            
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10),
            
            disclaimer.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 10),
            disclaimer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            disclaimer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),

            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            logoutButton.widthAnchor.constraint(equalToConstant: 200),
            logoutButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func fetchProfileData() {
        let url = URL(string: GoogleSignInManager.shared.getUserImageURL())
        DispatchQueue.main.async { [weak self] in
            self?.profileImage.sd_setImage(with: url)
            self?.userName.text = GoogleSignInManager.shared.getUserName()
            self?.email.text = GoogleSignInManager.shared.getUserEmail()
        }
    }
    
    @objc private func handleLogout() {
        GoogleSignInManager.shared.signOut()
        
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            dismiss(animated: true)
            sceneDelegate.window?.rootViewController = LoginVC()
        }
    }
}
