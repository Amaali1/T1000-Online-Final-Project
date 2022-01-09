//
//  PostDetailsVC.swift
//  finalproject7
//
//  Created by Amaal  on 01/01/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import NVActivityIndicatorView
class PostDetailsVC: UIViewController {
    
    var post: Post!
    var comments: [Comment] = []
    
    
    
    // MARK: OUTLETS
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var commentsTableView: UITableView!
    @IBOutlet weak var exiteButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var numberOfLikesLabel: UILabel!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var newCommentStackView: UIStackView!
    
    // MARK: LIFE CYCLE METHODS
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if UserManager.loggedInUser == nil {
            newCommentStackView.isHidden = true
        }
        commentsTableView.delegate = self
        commentsTableView.dataSource = self
        
        
        exiteButton.layer.cornerRadius = exiteButton.frame.width / 2
        userNameLabel.text = post.owner.firstName + " " + post.owner.lastName
        postTextLabel.text = post.text
        numberOfLikesLabel.text = String(post.likes)
        if let image = post.owner.picture{
            userImageView.setImageFromStringUrl(stringUrl: image)
        }
       
        postImageView.setImageFromStringUrl(stringUrl: post.image)
        userImageView.makeCircularImage()
        
        // Getting the comments of the post from API
        getPostComments()
    }
    
    func getPostComments(){
        loaderView.startAnimating()
        PostAPI.getPostComments(id: post.id) { commentsResponse in
            self.comments = commentsResponse
            self.commentsTableView.reloadData()
            self.loaderView.stopAnimating()
        }
    }
    
    // MARK: ACTIONS
    @IBAction func closeButtenClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func sendButtonClicked(_ sender: Any) {
        let message = commentTextField.text!
        
        if let user = UserManager.loggedInUser {
            loaderView.startAnimating()
            PostAPI.addNewCommentToPost(postId: post.id, userId: user.id, message: message) {
                self.getPostComments()
                self.commentTextField.text = ""
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

}

extension PostDetailsVC: UITableViewDelegate, UITableViewDataSource {
    

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return comments.count
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
    
    let currentComment = comments[indexPath.row]
    cell.userNameLabel.text = currentComment.owner.firstName + " " + currentComment.owner.lastName
    
    cell.commentMessageLabel.text = comments[indexPath.row].message
    
    if let userImage = currentComment.owner.picture {
        
        cell.userImageView.setImageFromStringUrl(stringUrl: userImage)
    }
    
    cell.userImageView.makeCircularImage()
    return cell
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}
