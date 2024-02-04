//
//  ArticleInteractor.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation
import Alamofire

protocol ArticleInteractorProtocol {
    func fetchArticles(source: String, page: Int, completion: @escaping ([ArticleEntity], String) -> Void)
    func searchArticles(search: String, source: String, page: Int, completion: @escaping ([ArticleEntity], String) -> Void)
}

class ArticleInteractor: ArticleInteractorProtocol {
        
    func fetchArticles(source: String, page: Int, completion: @escaping ([ArticleEntity], String) -> Void) {
        let path = apiHost + "top-headlines"
        
        let param: [String:Any] = [
            "sources": source,
            "apiKey": apiKey,
            "page": page,
            "pageSize": 10]
        
        AF.request(path, method: .get, parameters: param)
            .validate()
            .responseDecodable(of: ArticleResponse.self) { response in
                switch response.result {
                case .success(let entity):
                    completion(entity.articles, String(entity.totalResults))
                case .failure(let error):
                    completion([],error.errorDescription ?? "Unidentified Error")
                }
            }
    }
    
    func searchArticles(search: String, source: String, page: Int, completion: @escaping ([ArticleEntity], String) -> Void) {
        let path = apiHost + "everything"
        
        let param: [String:Any] = [
            "q": search,
            "sources": source,
            "apiKey": apiKey,
            "page": page]
        
        AF.request(path, method: .get, parameters: param)
            .validate()
            .responseDecodable(of: ArticleResponse.self) { response in
                switch response.result {
                case .success(let entity):
                    completion(entity.articles, String(entity.totalResults))
                case .failure(let error):
                    completion([],error.errorDescription ?? "Unidentified Error")
                }
            }
    }
}
