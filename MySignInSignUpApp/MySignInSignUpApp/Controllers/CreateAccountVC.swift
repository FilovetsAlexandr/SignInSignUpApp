//
//  CreateAccountVC.swift
//  MySignInSignUpApp
//
//  Created by MacBookPro15 on 23.08.23.
//

import UIKit

class CreateAccountVC: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
