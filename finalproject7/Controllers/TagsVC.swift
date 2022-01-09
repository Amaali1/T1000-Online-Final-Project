//
//  TagsVC.swift
//  finalproject7
//
//  Created by Amaal  on 08/01/2022.
//

import UIKit
import NVActivityIndicatorView

class TagsVC: UIViewController {

    var tags:[String] = []
    
    // MARK: OUTLET
    @IBOutlet weak var loaderView: NVActivityIndicatorView!
    @IBOutlet weak var tagsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tagsCollectionView.delegate = self
        tagsCollectionView.dataSource = self
        
        loaderView.startAnimating()
        PostAPI.getAllTags { tags in
            self.loaderView.stopAnimating()
            self.tags = tags
            self.tagsCollectionView.reloadData()
        }

    }
    
}
    
    extension TagsVC: UICollectionViewDelegate,UICollectionViewDataSource {
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return tags.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCell", for: indexPath) as! TagCell
            
            let currentTag = tags[indexPath.row].trimmingCharacters(in: .whitespaces)
            
            cell.tagNameLabel.text = "#" + currentTag
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let selectedTag = tags[indexPath.row]
            let vc =
            storyboard?.instantiateViewController(withIdentifier: "PostsVC") as! PostsVC
            vc.tag = selectedTag
            self.present(vc, animated: true, completion: nil)
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


