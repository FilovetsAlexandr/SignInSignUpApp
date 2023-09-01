//
//  TabBarController.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 30.08.23.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}
