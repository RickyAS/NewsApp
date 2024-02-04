//
//  SourceTest.swift
//  NewsAppTests
//
//  Created by amartek on 03/02/24.
//

import XCTest
@testable import NewsApp

final class SourceTest: XCTestCase {
    var presenter: SourcePresenterProtocol!
    var interactor: SourceInteractorMock!
    var router: SourceRouterProtocol!
    var category: NewsCategories!
    
    override func setUpWithError() throws {
        category = NewsCategories.general
        interactor = SourceInteractorMock()
        router = SourceRouter(UINavigationController(), title: "")
    }

    override func tearDownWithError() throws {
        category = nil
        interactor = nil
        router = nil
        presenter = nil
    }

    func testSuccessGetSources() throws {
        interactor.jsonString = SourceResponseMock.successGetPage
        presenter = SourcePresenter(category: category, interactor: interactor, router: router)
        presenter.getSources {
            XCTAssertGreaterThan(self.presenter.getSourcesSize(),0)
        }
    }

    func testSuccessGetEmptySources() throws {
        interactor.jsonString = SourceResponseMock.successGetEmptyPage
        presenter = SourcePresenter(category: category, interactor: interactor, router: router)
        presenter.getSources {
            XCTAssertEqual(self.presenter.getSourcesSize(), 0)
        }
    }
    
    func testFailGetSources() throws {
        interactor.jsonString = SourceResponseMock.failGetPage
        presenter = SourcePresenter(category: category, interactor: interactor, router: router)
        presenter.getSources {
            XCTAssertEqual(self.presenter.getSourcesSize(), 0)
        }
    }
    
    func testSuccessSearchSource() throws {
        interactor.jsonString = SourceResponseMock.successGetPage
        presenter = SourcePresenter(category: category, interactor: interactor, router: router)
        presenter.getSources {
            self.presenter.searchSource(text: "Ars") {
                XCTAssertGreaterThan(self.presenter.getSourcesSize(),0)
            }
        }
    }
    
    func testSuccessSearchEmptySource() throws {
        interactor.jsonString = SourceResponseMock.successGetPage
        presenter = SourcePresenter(category: category, interactor: interactor, router: router)
        presenter.getSources {
            self.presenter.searchSource(text: "Tesla") {
                XCTAssertEqual(self.presenter.getSourcesSize(), 0)
            }
        }
    }

}

class SourceInteractorMock: SourceInteractorProtocol {
    var jsonString = ""
    
    func fetchSources(category: String, completion: @escaping ([SourceEntity], String?) -> Void) {
        let data = Data(jsonString.utf8)
        if let entity = try? JSONDecoder().decode(SourceResponse.self, from: data) {
            completion(entity.sources,nil)
        } else {
            completion([],"Error")
        }
    }
}
