//
//  HomeTests.swift
//  HomeTests
//
//  Created by Ricky Austin on 01/02/24.
//

import XCTest
@testable import NewsApp

final class HomeTests: XCTestCase {
    var presenter: HomePresenterProtocol!
    
    override func setUpWithError() throws {
        let router = HomeRouter(UINavigationController(), title: "")
        presenter = HomePresenter(router: router)
    }

    override func tearDownWithError() throws {
        presenter = nil
    }

    func testCategorySize() throws {
        let size = presenter.getCategorySize()
        XCTAssertGreaterThan(size, 0)
    }

}

