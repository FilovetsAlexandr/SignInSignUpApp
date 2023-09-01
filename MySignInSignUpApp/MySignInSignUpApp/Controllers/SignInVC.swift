//
//  SignInVC.swift
//  MySignInSignUpApp
//
//  Created by MacBookPro15 on 23.08.23.
//

import UIKit

class SignInVC: BaseViewController {
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var passTF: UITextField!
    @IBOutlet var errorLbl: UILabel!
    @IBOutlet var signInBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        dismissKeyboard()
        // в идеале надо в UserDefaults записать булевое значение залогирован ли юзер
        if let _ = UserDefaultsService.getUserModel() { goToBarController() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTF.text = ""
        passTF.text = ""
    }
    
    @IBAction func signInAction() {
        errorLbl.isHidden = true
        guard let email = emailTF.text,
              let pass = passTF.text,
              let userModel = UserDefaultsService.getUserModel(),
              email == userModel.email,
              pass == userModel.pass
        else {
            errorLbl.isHidden = false
            return
        }
        goToBarController()
    }
    
    private func setupUI() {
        //       signInBtn.isEnabled = false
        errorLbl.isHidden = true
    }
    
    private func goToBarController() {
        let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
