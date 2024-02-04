//
//  HomePresenter.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation

protocol HomePresenterProtocol {
    func getCategorySize() -> Int
    func getCategory(row: Int) -> NewsCategories
    func openNewsSource(row: Int)
    
}
class HomePresenter: HomePresenterProtocol {
    let router: HomeRouterProtocol
    
    init(router: HomeRouterProtocol){
        self.router = router
    }
    
    var list: [NewsCategories] {
        [.general, .business, .entertainment, .sports, .technology, .health]
    }
    
    func getCategorySize() -> Int {
        list.count
    }
    
    func getCategory(row: Int) -> NewsCategories {
        list[row]
    }
    
    func openNewsSource(row: Int) {
        router.pushSourceView(category: list[row])
    }
}
