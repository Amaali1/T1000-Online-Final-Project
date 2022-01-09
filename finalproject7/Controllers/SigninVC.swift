//
//  SigninVC.swift
//  finalproject7
//
//  Created by Amaal  on 08/01/2022.
//

import UIKit
import Spring
import NVActivityIndicatorView

class SigninVC: UIViewController {
    // MARK: OUTLETS
    
    
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var amaalLabel: SpringLabel!
    @IBOutlet weak var welcomeToLabel: SpringLabel!
    @IBOutlet weak var tuwaiqLabel: SpringLabel!
    @IBOutlet weak var logoImageView: SpringImageView!
    @IBOutlet weak var introView: SpringView!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    // MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.firstNameTextField.text = "Amaal"
        self.lastNameTextField.text = "Ibrahim"
        
        animateIn()
        
        // Do any additional setup after loading the view.
    }
    // MARK: ACTIONS
    
    func animateIn(){
        introView.animation = "zoomOut"
        introView.delay = 4
        introView.duration = 0.5
        
        tuwaiqLabel.animation = "fadeInDown"
        tuwaiqLabel.duration = 1
        tuwaiqLabel.delay = 0.5
        tuwaiqLabel.animate()
        
        welcomeToLabel.animation = "fadeInRight"
        welcomeToLabel.duration = 2
        welcomeToLabel.delay = 1
        welcomeToLabel.animate()
        
        amaalLabel.animation = "fadeInUp"
        amaalLabel.delay = 1.2
        amaalLabel.duration = 1
        amaalLabel.animate()
        
        logoImageView.animation = "zoomIn"
        logoImageView.animate()
        logoImageView.animation = "swing"
        logoImageView.animate()
        introView.animate()
        // introView.isHidden = true
        
        
    }
    
    
    @IBAction func signinButtonClicked(_ sender: Any) {
        
        loaderView.startAnimating()
        UserAPI.signInUser(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!) { user, errorMessage in
            
            self.loaderView.stopAnimating()
            if let message = errorMessage {
                let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
                let action =  UIAlertAction(title: "ok", style: .default, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }else {
                
                if let loggedInUser = user{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainTabViewController")
                    UserManager.loggedInUser = loggedInUser
                    self.present(vc!, animated: true, completion: nil)
                    
                }
            }
            
        }
        
    }
}


/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destination.
 // Pass the selected object to the new view controller.
 }
 */


