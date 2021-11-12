//
//  Service.swift
//  UserDetail
//
//  Created by Umair Yousaf on 09/11/2021.
//

import Foundation

class Service {
    
    func getUserResponse(completion: @escaping (_ list: [ResponseModel]) -> Void) {
        
        let urlString = "https://api.github.com/users?since=0​"
        let output = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: output!)
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                
                do {
                    let json = try JSONDecoder().decode([ResponseModel].self, from: data)
                    completion(json)
                }
                catch {

                    print(error.localizedDescription)
                }
                
            }
            
        }
        task.resume()
        
    }
    
    func getOrgnizationResponse( link : String , completion: @escaping (_ list: [OrgnizationResponseModel]) -> Void) {
        
        let urlString = link
        
        let url = URL(string: urlString )
        guard let requestUrl = url else { fatalError() }
        var request = URLRequest(url: requestUrl)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                
                do {
                    let json = try JSONDecoder().decode([OrgnizationResponseModel].self, from: data)
                    completion(json)
                }
                catch {

                    print(error.localizedDescription)
                }
                
            }
            
        }
        task.resume()
        
    }
}
