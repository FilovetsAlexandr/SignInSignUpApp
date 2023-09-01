//
//  WelcomeVC.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 29.08.23.
//

import UIKit

class WelcomeVC: UIViewController {
    @IBOutlet var infoLbl: UILabel!
    
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func continueAction() {
        guard let userModel = userModel else { return }
        UserDefaultsService.saveUserModel(userModel: userModel)
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() { infoLbl.text = "\(userModel?.name ?? "") " }
}
