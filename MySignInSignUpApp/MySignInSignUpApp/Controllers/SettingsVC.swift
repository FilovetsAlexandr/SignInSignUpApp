//
//  SettingsVC.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 30.08.23.
//

import UIKit

class SettingsVC: BaseViewController {
    var userModel: UserModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }

    @IBAction func deleteAccountAction() { UserDefaultsService.cleanUserDefaults() }

    @IBAction func logOutAction() { navigationController?.popToRootViewController(animated: true) }
}
