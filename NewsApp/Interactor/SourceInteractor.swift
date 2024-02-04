//
//  NewsInteractor.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation
import Alamofire

// let apiKey = "39f706975d4a4565ad48fcc608430d28"
let apiKey = "71ed45933024470996df8a68567dc975"
let apiHost = "https://newsapi.org/v2/"

protocol SourceInteractorProtocol {
    func fetchSources(category: String, completion: @escaping ([SourceEntity], String?) -> Void)
}

class SourceInteractor: SourceInteractorProtocol {
    
    func fetchSources(category: String, completion: @escaping ([SourceEntity], String?) -> Void) {
        let path = apiHost + "top-headlines/sources"
        
        let param: [String:Any] = [
            "category": category,
            "apiKey": apiKey]
        
        AF.request(path, method: .get, parameters: param)
            .validate()
            .responseDecodable(of: SourceResponse.self) { response in
                switch response.result {
                case .success(let entity):
                    completion(entity.sources, nil)
                case .failure(let error):
                    completion([],error.errorDescription)
                }
            }
    }
}
