//
//  UserDefaultsService.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 30.08.23.
//

import Foundation

final class UserDefaultsService {
    static func saveUserModel(userModel: UserModel) {
        UserDefaults.standard.setValue(userModel.name, forKey: UserDefaults.Keys.name.rawValue)
        UserDefaults.standard.setValue(userModel.email, forKey: UserDefaults.Keys.email.rawValue)
        UserDefaults.standard.setValue(userModel.pass, forKey: UserDefaults.Keys.pass.rawValue)
    }

    static func getUserModel() -> UserModel? {
        let name = UserDefaults.standard.string(forKey: UserDefaults.Keys.name.rawValue)
        guard let email = UserDefaults.standard.string(forKey: UserDefaults.Keys.email.rawValue),
              let pass = UserDefaults.standard.string(forKey: UserDefaults.Keys.pass.rawValue) else { return nil }
        let userModel = UserModel(name: name, email: email, pass: pass)
        return userModel
    }

    static func cleanUserDefaults() {
        UserDefaults.standard.reset()
    }
}
