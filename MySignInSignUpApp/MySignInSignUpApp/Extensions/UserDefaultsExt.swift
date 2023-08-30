//
//  UserDefaultsExt.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 30.08.23.
//

import Foundation

extension UserDefaults {
    /// Протокол, позволяющий энам (кейс) превратить в массив типа Стринг
    enum Keys: String, CaseIterable {
        case email
        case name
        case pass
    }

    func reset() {
        let allCases = Keys.allCases
        allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}
