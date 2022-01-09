//
//  NewPostVC.swift
//  finalproject7
//
//  Created by Amaal  on 09/01/2022.
//

import UIKit
import NVActivityIndicatorView

class NewPostVC: UIViewController {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var postTextTextField: UITextField!
    @IBOutlet weak var postImageTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addNewPostClicked(_ sender: Any) {
        
        if let user = UserManager.loggedInUser
        {
            addButton.setTitle("", for: .normal)
            loaderView.startAnimating()
            
            PostAPI.addNewPost(text: postTextTextField.text!, userId: user.id, imageUrl: postImageTextField.text!){
                
                self.loaderView.stopAnimating()
                self.addButton.setTitle("Add New Post", for: .normal)
                NotificationCenter.default.post(name: NSNotification.Name("NewPostAdded"), object: nil, userInfo: nil)
                self.dismiss(animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
