//
//  SourcePresenter.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation

protocol SourcePresenterProtocol {
    func getSources(completion: @escaping () -> Void)
    func searchSource(text: String, completion: @escaping () -> Void)
    func getSourcesSize() -> Int
    func getSource(row: Int) -> SourceEntity
    func openNewsArticle(row: Int)
}

class SourcePresenter: SourcePresenterProtocol {
    let interactor: SourceInteractorProtocol
    let router: SourceRouterProtocol
    let category: NewsCategories
    var sources = [SourceEntity]()
    var tempSources = [SourceEntity]()
    
    init(category: NewsCategories, interactor: SourceInteractorProtocol, router: SourceRouterProtocol) {
        self.category = category
        self.interactor = interactor
        self.router = router
    }
    
    func getSources(completion: @escaping () -> Void) {
        interactor.fetchSources(category: category.rawValue) { [weak self] entities, errMsg in
            if let errMsg =  errMsg {
                self?.router.presentAlert(message: errMsg)
                return
            }
            self?.tempSources = entities
            self?.sources = entities
            completion()
        }
    }
    
    func searchSource(text: String, completion: @escaping () -> Void) {
        tempSources = sources
        if !text.isEmpty {
            tempSources = tempSources.filter({ $0.name.localizedCaseInsensitiveContains(text) })
        }
        completion()
    }
    
    func getSourcesSize() -> Int {
        tempSources.count
    }
    
    func getSource(row: Int) -> SourceEntity {
        tempSources[row]
    }
    
    func openNewsArticle(row: Int) {
        let source = tempSources[row]
        router.pushArticleView(sourceId: source.id, sourceName: "\(source.name) \(source.flag)")
    }
}
