//
//  ArticleTest.swift
//  NewsAppTests
//
//  Created by amartek on 03/02/24.
//

import XCTest
@testable import NewsApp

final class ArticleTest: XCTestCase {
    var presenter: ArticlePresenterProtocol!
    var interactor: ArticleInteractorMock!
    var router: ArticleRouterProtocol!
    var sourceId: String!
    
    override func setUpWithError() throws {
        sourceId = "ars-technica"
        interactor = ArticleInteractorMock()
        router = ArticleRouter(UINavigationController(), title: "")
    }

    override func tearDownWithError() throws {
        sourceId = nil
        interactor = nil
        router = nil
        presenter = nil
    }

    func testSuccessGetArticles() throws {
        interactor.jsonString = ArticleResponseMock.successGetPage
        presenter = ArticlePresenter(sourceId: sourceId, interactor: interactor, router: router)
        presenter.getArticles(isReload: true)
        presenter.onFinish = { [unowned self] in
            XCTAssertGreaterThan(presenter.getArticlesSize(), 0)
        }
    }

    func testSuccessGetEmptyArticles() throws {
        interactor.jsonString = ArticleResponseMock.successGetEmptyPage
        presenter = ArticlePresenter(sourceId: sourceId, interactor: interactor, router: router)
        presenter.getArticles(isReload: true)
        presenter.onFinish = { [unowned self] in
            XCTAssertEqual(presenter.getArticlesSize(), 0)
        }
    }
    
    func testFailGetArticles() throws {
        interactor.jsonString = ArticleResponseMock.failGetPage
        presenter = ArticlePresenter(sourceId: sourceId, interactor: interactor, router: router)
        presenter.getArticles(isReload: true)
        presenter.onFinish = { [unowned self] in
            XCTAssertEqual(presenter.getArticlesSize(), 0)
        }
    }
    
    func testSuccessSearchArticle() throws {
        interactor.jsonString = ArticleResponseMock.successGetPage
        presenter = ArticlePresenter(sourceId: sourceId, interactor: interactor, router: router)
        presenter.searchText = "Rock"
        presenter.searchArticle(isReload: true)
        presenter.onFinish = { [unowned self] in
            XCTAssertGreaterThan(self.presenter.getArticlesSize(),0)
        }
    }
    
    func testSuccessSearchEmptyArticle() throws {
        interactor.jsonString = ArticleResponseMock.successGetPage
        presenter = ArticlePresenter(sourceId: sourceId, interactor: interactor, router: router)
        presenter.searchText = "Rocks"
        presenter.searchArticle(isReload: true)
        presenter.onFinish = { [unowned self] in
            XCTAssertEqual(self.presenter.getArticlesSize(),0)
        }
    }
    
    func testFailSearchArticle() throws {
        interactor.jsonString = ArticleResponseMock.failGetPage
        presenter = ArticlePresenter(sourceId: sourceId, interactor: interactor, router: router)
        presenter.searchText = "Rock"
        presenter.searchArticle(isReload: true)
        presenter.onFinish = { [unowned self] in
            XCTAssertEqual(self.presenter.getArticlesSize(),0)
        }
    }

}

class ArticleInteractorMock: ArticleInteractorProtocol {
    var jsonString = ""
    
    func fetchArticles(source: String, page: Int, completion: @escaping ([ArticleEntity], String) -> Void) {
        let data = Data(jsonString.utf8)
        if let entity = try? JSONDecoder().decode(ArticleResponse.self, from: data) {
            completion(entity.articles,String(10))
        } else {
            completion([],"Error")
        }
    }
    
    func searchArticles(search: String, source: String, page: Int, completion: @escaping ([ArticleEntity], String) -> Void) {
        let data = Data(jsonString.utf8)
        if let entity = try? JSONDecoder().decode(ArticleResponse.self, from: data) {
            let articles = entity.articles.filter({ $0.title.localizedCaseInsensitiveContains(search) })
            completion(articles,String(10))
        } else {
            completion([],"Error")
        }
    }
}
