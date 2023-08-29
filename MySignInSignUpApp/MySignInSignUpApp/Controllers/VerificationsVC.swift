//
//  VerificationsVC.swift
//  MySignInSignUpApp
//
//  Created by Alexandr Filovets on 29.08.23.
//

import UIKit

class VerificationsVC: BaseViewController {
    var userModel: UserModel?
    let randomInt = Int.random(in: 100000 ... 999999)
    var sleepTime = 3

    @IBOutlet var infoLbl: UILabel!
    @IBOutlet var codeTF: UITextField!
    @IBOutlet var errorCodeLbl: UILabel!
    @IBOutlet var centerYConstraint: NSLayoutConstraint!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hideKeyboardWhenTappedAround()
        startKeyboardObserver()
    }
        
    @IBAction func codeTFAction(_ sender: UITextField) {
        errorCodeLbl.isHidden = true
        guard let text = sender.text,
                 !text.isEmpty,
                  text == randomInt.description
        else {
            errorCodeLbl.isHidden = false
            sender.isUserInteractionEnabled = false
            errorCodeLbl.text = "Error code. Please wait \(sleepTime) seconds"

            let dispatcAfter = DispatchTimeInterval.seconds(sleepTime)
            let deadline = DispatchTime.now() + dispatcAfter
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                sender.isUserInteractionEnabled = true
                self.errorCodeLbl.isHidden = true
                self.sleepTime *= 2
            }
            return
        }
        performSegue(withIdentifier: "goToWelcomeScreen", sender: nil)
    }

    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant -= keyboardSize.height / 2
    }

    @objc private func keyboardWillHide(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.constant += keyboardSize.height / 2
    }

    private func setupUI() {
        infoLbl.text = "Please enter code '\(randomInt)' from \(userModel?.email ?? "")"
    }

       //  MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destVC = segue.destination as? WelcomeVC else { return }
        destVC.userModel = userModel
    }
}
