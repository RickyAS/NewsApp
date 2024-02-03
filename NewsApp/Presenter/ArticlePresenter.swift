//
//  ArticlePresenter.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation

protocol ArticlePresenterProtocol {
    var searchText: String {get set}
    var onFinish: (()->Void)? {get set}
    func getArticles(isReload: Bool)
    func searchArticle(isReload: Bool)
    func getArticlesSize() -> Int
    func getArticle(row: Int) -> ArticleEntity
    func openWebArticle(row: Int)
}

class ArticlePresenter: ArticlePresenterProtocol {
    let interactor: ArticleInteractorProtocol
    let router: ArticleRouterProtocol
    let sourceId: String
    var page = 1
    var totalResults = 0
    var articles = [ArticleEntity]()
    
    var searchText = ""
    var onFinish: (() -> Void)?
    
    init(sourceId: String, interactor: ArticleInteractorProtocol, router: ArticleRouterProtocol) {
        self.sourceId = sourceId
        self.interactor = interactor
        self.router = router
    }
    
    func getArticles(isReload: Bool) {
        if !isReload && getArticlesSize() >= totalResults {
            return
        }
        if isReload {
            page = 1
            articles = []
        } else {
            page += 1
        }
        interactor.fetchArticles(source: sourceId, page: page) { [weak self] entities, msg in
            if let totalResults = Int(msg) {
                self?.totalResults = totalResults
                self?.articles += entities
                self?.onFinish?()
            } else {
                self?.router.presentAlert(message: msg)
            }
        }
    }
    
    func searchArticle(isReload: Bool) {
        if !isReload && getArticlesSize() >= totalResults {
            return
        }
        if isReload {
            page = 1
            articles = []
        } else {
            page += 1
        }
        interactor.searchArticles(search: searchText, source: sourceId, page: page) { [weak self] entities, msg in
            if let totalResults = Int(msg) {
                self?.totalResults = totalResults
                self?.articles += entities
                self?.onFinish?()
            } else {
                self?.router.presentAlert(message: msg)
            }
        }
    }
    
    func getArticlesSize() -> Int {
        articles.count
    }
    
    func getArticle(row: Int) -> ArticleEntity {
        articles[row]
    }
    
    func openWebArticle(row: Int) {
        let urlString = articles[row].url
        router.pushWebArticleView(urlString: urlString)
    }
    
    
}
 
