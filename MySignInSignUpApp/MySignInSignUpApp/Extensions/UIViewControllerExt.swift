//
//  File.swift
//  MySignInSignUpApp
//
//  Created by Home on 29.08.23.
//

import UIKit

class BaseViewController: UIViewController {
    func hideKeyboardWhenTappedAround() {
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tap.cancelsTouchesInView = false
            view.addGestureRecognizer(tap)
        }

        @objc func dismissKeyboard() {
            view.endEditing(true)
        }
}
