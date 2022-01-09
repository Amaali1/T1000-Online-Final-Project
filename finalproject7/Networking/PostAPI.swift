//
//  PostAPI.swift
//  finalproject7
//
//  Created by Amaal  on 07/01/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class PostAPI: API {
    
    
    
    static func getAllPosts(page: Int, tag: String?, complationHandler: @escaping ([Post], Int) -> ()){
        
    var url = baseURL + "/post"
        
        if var myTag = tag {
            myTag = myTag.trimmingCharacters(in: .whitespaces)
             url = "\(baseURL)/tag/\(myTag)/post"
        }
        
        let params = ["page": "\(page)",
                      "limit": "5"
        ]
        
        AF.request(url, parameters: params,encoder: URLEncodedFormParameterEncoder.default, headers: headers).responseJSON { response in
            
            let jasonData = JSON(response.value)
            let data = jasonData["data"]
            let total = jasonData["total"].intValue
            let decoder = JSONDecoder()
            do {
                let posts = try decoder.decode([Post].self, from: data.rawData())
                complationHandler(posts, total)
            }catch let error{
                print(error)
            }
            
        }
    }
    
    static func addNewPost( text: String, userId: String, imageUrl: String, complationHandler: @escaping () -> ()){
        
        let url = "\(baseURL)/post/create"
        let params = [
            "owner": userId,
            "text": text,
            "image": imageUrl
        ]
        
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
               complationHandler()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    //MARK: TAG API
    static func getAllTags(complationHandler: @escaping ([String]) -> ()){
    
        let url = "\(baseURL)/tag"
        AF.request(url, headers: headers).responseJSON { response in
            
            let jasonData = JSON(response.value)
            let data = jasonData["data"]
            let decoder = JSONDecoder()
            do {
                let tags = try decoder.decode([String].self, from: data.rawData())
                complationHandler(tags)
            }catch let error{
                print(error)
            }
        }
    }
    
    static func getPostComments(id: String, complitionHandler: @escaping ([Comment]) -> ()){
        
        let url = "\(baseURL)/post/\(id)/comment"
        AF.request(url, headers: headers).responseJSON { response in
            
            let jasonData = JSON(response.value)
            let data = jasonData["data"]
            let decoder = JSONDecoder()
            do {
               let comments = try decoder.decode([Comment].self, from: data.rawData())
                complitionHandler(comments)
            }catch let error{
                print(error)
            }
        }
    }
    
    // MARK: COMMENT API
    static func addNewCommentToPost( postId: String, userId: String, message: String, complationHandler: @escaping () -> ()){
        
        let url = "\(baseURL)/comment/create"
        let params = [
            "post": postId,
            "message": message,
            "owner": userId
        ]
        
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                complationHandler()
            case .failure(let error):
                print(error)
                
            }
            
        }
    }
}
