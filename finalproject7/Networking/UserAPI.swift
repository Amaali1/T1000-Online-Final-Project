//
//  UserAPI.swift
//  finalproject7
//
//  Created by Amaal  on 07/01/2022.
//

import Foundation
import Alamofire
import SwiftyJSON

class UserAPI: API {
    static func getUserData(id: String,  complationHandler: @escaping(User) -> ()){
        
        let url = "\(baseURL)/user/\(id)"
        
        AF.request(url, headers: headers).responseJSON { response in
            let jasonData = JSON(response.value)
            let decoder = JSONDecoder()
            do {
                let user = try decoder.decode(User.self, from: jasonData.rawData())
                complationHandler(user)
                
            }catch let error{
                print(error)
            }
        }
    }
    
    
    static func registerNewUser( firstName: String, lastName: String, email: String, complationHandler: @escaping (User?, String? ) -> ()){
        
        let url = "\(baseURL)/user/create"
        let params = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email
        ]
        
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jasonData = JSON(response.value)
                print(jasonData)
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jasonData.rawData())
                    complationHandler(user, nil)
                    
                }catch let error{
                    print(error)
                }
            case .failure(let error):
                let jasonData = JSON(response.data)
                let data = jasonData["data"]
                
                //error messages
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                
                let errorMessage = emailError + " \n" + firstNameError + "\n " + lastNameError
                    complationHandler(nil, errorMessage)
                    
            }
            
        }
    }
    
    static func signInUser( firstName: String, lastName: String, complationHandler: @escaping (User?, String? ) -> ()){
        
        let url = "\(baseURL)/user"
        let params = [
            "created": "1"
        ]
        
        AF.request(url, method: .get, parameters: params, encoder: URLEncodedFormParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jasonData = JSON(response.value)
                let data = jasonData["data"]
                print(jasonData)
                let decoder = JSONDecoder()
                do {
                    let users = try decoder.decode([User].self, from: data.rawData())
                    
                    var foundUser: User?
                    for user in users {
                        if user.firstName == firstName && user.lastName == lastName {
                            foundUser = user
                            break
                        }
                    }
                    if let user = foundUser {
                        complationHandler(foundUser, nil)
                    }else {
                        
                        complationHandler(nil, "Sorry! the first name or the last name doesn't match any user")
                    }

                }catch let error{
                    print(error)
                }
            case .failure(let error):
                let jasonData = JSON(response.data)
                let data = jasonData["data"]
                
                //error messages
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                
                let errorMessage = emailError + " \n" + firstNameError + "\n " + lastNameError
                    complationHandler(nil, errorMessage)
                    
            }
            
        }
    }
    
    static func updateUserInfo( userId: String, firstName: String, phone: String, imageUrl: String, complationHandler: @escaping (User?, String? ) -> ()){
        
        let url = "\(baseURL)/user/\(userId)"
        let params = [
            "firstName": firstName,
            "phone": phone,
            "picture": imageUrl
        ]
        
        AF.request(url, method: .put, parameters: params, encoder: JSONParameterEncoder.default, headers: headers).validate().responseJSON { response in
            switch response.result{
            case .success:
                let jasonData = JSON(response.value)
                
                let decoder = JSONDecoder()
                do {
                    let user = try decoder.decode(User.self, from: jasonData.rawData())
                    
                    complationHandler(user,nil)

                }catch let error{
                    print(error)
                }
            case .failure(let error):
                let jasonData = JSON(response.data)
                let data = jasonData["data"]
                
                //error messages
                let emailError = data["email"].stringValue
                let firstNameError = data["firstName"].stringValue
                let lastNameError = data["lastName"].stringValue
                
                let errorMessage = emailError + " \n" + firstNameError + "\n " + lastNameError
                    complationHandler(nil, errorMessage)
                    
            }
            
        }
    }
    
}
