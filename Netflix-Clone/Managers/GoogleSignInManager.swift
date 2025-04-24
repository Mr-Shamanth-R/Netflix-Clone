//
//  GoogleSignInManager.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 22/04/25.
//

import GoogleSignIn
import GoogleSignInSwift
import UIKit

class GoogleSignInManager {
    static let shared = GoogleSignInManager()
    private init() {}

    var user: GIDGoogleUser? {
        return GIDSignIn.sharedInstance.currentUser
    }

    func signIn(presentingVC: UIViewController, completion: @escaping (Bool) -> Void) {
        let clientID = "609860097382-d2ibo8gg0hki5odttttrl5c8d7cg53g0.apps.googleusercontent.com"
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
            DispatchQueue.main.async {
                if let result = result, error == nil {
                    let profile = result.user.profile

                    // ✅ Save to Keychain
                    KeychainHelper.shared.save("true", for: "isLoggedIn")
                    KeychainHelper.shared.save(profile?.name ?? "", for: "userName")
                    KeychainHelper.shared.save(profile?.email ?? "", for: "userEmail")
                    KeychainHelper.shared.save(profile?.imageURL(withDimension: 100)?.absoluteString ?? "", for: "userImageURL")

                    print("Google Sign-In Success: \(profile?.name ?? "")")
                    completion(true)
                } else {
                    print("Google Sign-In Failed: \(error?.localizedDescription ?? "")")
                    completion(false)
                }
            }
        }
    }

    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        KeychainHelper.shared.delete(for: "isLoggedIn")
        KeychainHelper.shared.delete(for: "userName")
        KeychainHelper.shared.delete(for: "userEmail")
        KeychainHelper.shared.delete(for: "userImageURL")
    }

    func isLoggedIn() -> Bool {
        return KeychainHelper.shared.read(for: "isLoggedIn") == "true"
    }

    func getUserName() -> String {
        return KeychainHelper.shared.read(for: "userName") ?? ""
    }

    func getUserEmail() -> String {
        return KeychainHelper.shared.read(for: "userEmail") ?? ""
    }

    func getUserImageURL() -> String {
        return KeychainHelper.shared.read(for: "userImageURL") ?? ""
    }
}
