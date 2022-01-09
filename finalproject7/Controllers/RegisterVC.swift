//
//  RegisterVC.swift
//  finalproject7
//
//  Created by Amaal  on 07/01/2022.
//

import UIKit

class RegisterVC: UIViewController {
// MARK: OUTLETS
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    //MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    // MARK: ACTIONS
    @IBAction func registerButtonClicked(_ sender: Any) {
        UserAPI.registerNewUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, email: emailTextField.text!) { user,errorMeessage in
            if errorMeessage != nil{
                let alert = UIAlertController(title: "Error", message: errorMeessage, preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }else {
                let alert = UIAlertController(title: "Success", message: " User Created", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(okAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func signInButtenClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
