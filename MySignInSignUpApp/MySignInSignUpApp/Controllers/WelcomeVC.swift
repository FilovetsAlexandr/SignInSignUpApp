//
//  WelcomeVC.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 29.08.23.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var infoLbl: UILabel!
    
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // TODO: SAVE DATA
    @IBAction func continueAction() { navigationController?.popToRootViewController(animated: true) }
    
    private func setupUI() { infoLbl.text = "\(userModel?.name ?? "") " }

}
