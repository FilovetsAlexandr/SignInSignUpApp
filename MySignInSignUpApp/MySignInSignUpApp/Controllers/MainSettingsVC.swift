//
//  MainSettingsVC.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 30.08.23.
//

import UIKit

class MainSettingsVC: BaseViewController {
    var userModel: UserModel?
    
    /// email
    @IBOutlet var emailTF: UITextField!
    @IBOutlet var errorEmailLBL: UILabel!
    /// name
    @IBOutlet var nameTF: UITextField!
    /// password
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var errorPassLbl: UILabel!
    /// strong password indicators
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    // confPass
    @IBOutlet var confPassTF: UITextField!
    @IBOutlet var errorConfPassLbl: UILabel!
    /// continueBtn
    @IBOutlet var continueBtn: UIButton!
    /// scrollView
    @IBOutlet var scrollView: UIScrollView!
    
    private var isValidEmail = false { didSet { updateContinueBtnState() } }
    private var isConfPass = false { didSet { updateContinueBtnState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() } }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email)
        {
            isValidEmail = true
        } else { isValidEmail = false }
        errorEmailLBL.isHidden = isValidEmail
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty
        {
            passwordStrength = VerificationService.isValidPassword(pass: passText)
        } else { passwordStrength = .veryWeak }
        errorPassLbl.isHidden = passwordStrength != .veryWeak
        setupStrongIndicatorsViews()
    }
    
    private func setupStrongIndicatorsViews() {
        strongPassIndicatorsViews.enumerated().forEach { index, view in
            view.alpha = index <= (passwordStrength.rawValue - 1) ? 1 : 0.2
        }
    }
    
    private func updateContinueBtnState() { continueBtn.isEnabled = isValidEmail && isConfPass && passwordStrength != .veryWeak }
    
    @IBAction func confPassTFAction(_ sender: UITextField) {
        if let confPassText = sender.text,
           !confPassText.isEmpty,
           let passText = passwordTF.text,
           !passText.isEmpty
        {
            isConfPass = VerificationService.isPassConfirm(pass1: passText, pass2: confPassText)
        } else { isConfPass = false }
        errorConfPassLbl.isHidden = isConfPass
    }
    
    @IBAction func continueAction() {
        if let email = emailTF.text,
           let pass = confPassTF.text,
           let name = nameTF.text
        {
            let userModelNew = UserModel(name: name, email: email, pass: pass)
            UserDefaultsService.saveUserModel(userModel: userModelNew)
            let storyboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
            guard let profileVC = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as? SettingsVC else { return }
            profileVC.userModel = userModelNew
            navigationController?.pushViewController(profileVC, animated: true)
        }
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }

    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}
