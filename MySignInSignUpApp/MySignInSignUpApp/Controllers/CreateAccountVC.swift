//
//  CreateAccountVC.swift
//  MySignInSignUpApp
//
//  Created by MacBookPro15 on 23.08.23.
//

import UIKit

class CreateAccountVC: BaseViewController {
    /// email
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var errorEmailLBL: UILabel!
    /// name
    @IBOutlet weak var nameTF: UITextField!
    /// password
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var errorPassLbl: UILabel!
    /// strong password indicators
    @IBOutlet var strongPassIndicatorsViews: [UIView]!
    //confPass
    @IBOutlet weak var confPassTF: UITextField!
    @IBOutlet weak var errorConfPassLbl: UILabel!
    /// continueBtn
    @IBOutlet weak var continueBtn: UIButton!
    /// scrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    private var isValidEmail = false { didSet { updateContinueBtnState() } }
    private var isConfPass = false { didSet { updateContinueBtnState() } }
    private var passwordStrength: PasswordStrength = .veryWeak { didSet { updateContinueBtnState() } }
        
    
    override func viewDidLoad() {
        super.viewDidLoad()
               strongPassIndicatorsViews.forEach { view in view.alpha = 0.2 }
               hideKeyboardWhenTappedAround()
               startKeyboardObserver()
               navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        if let email = sender.text,
           !email.isEmpty,
           VerificationService.isValidEmail(email: email) {
            isValidEmail = true
        } else { isValidEmail = false }
        errorEmailLBL.isHidden = isValidEmail
    }
    
    @IBAction func passTFAction(_ sender: UITextField) {
        if let passText = sender.text,
           !passText.isEmpty {
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
           !passText.isEmpty {
            isConfPass = VerificationService.isPassConfirm(pass1: passText, pass2: confPassText)
        } else { isConfPass = false }
        errorConfPassLbl.isHidden = isConfPass
}
    
    
    @IBAction func signInAction() { navigationController?.popToRootViewController(animated: true) }
    
    
    
    @IBAction func continueAction() {
        if let email = emailTF.text,
           let pass = passwordTF.text
        {
            let userModel = UserModel(name: nameTF.text, email: email, pass: pass)
            performSegue(withIdentifier: "goToVerificationScreen", sender: userModel)
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

   //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? VerificationsVC,
              let userModel = sender as? UserModel else { return }
        destVC.userModel = userModel
    }
}
