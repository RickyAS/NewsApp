//
//  HomeRouter.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation
import UIKit

protocol BaseRouterProtocol {
    var title: String { get }
    var navigation: UINavigationController { get }
    init(_ navigation: UINavigationController, title: String)
    func start()
}

protocol HomeRouterProtocol {
    func pushSourceView(category: NewsCategories)
}

class HomeRouter: BaseRouterProtocol, HomeRouterProtocol {
    var title: String
    var navigation: UINavigationController
    
    required init(_ navigation: UINavigationController, title: String) {
        self.navigation = navigation
        self.title = title
    }
    
    func start() {
        let view = HomeController(nibName: nil, bundle: nil)
        view.presenter = HomePresenter(router: self)
        view.navigationItem.title = title
        // view.navigationItem.hidesBackButton = true
        navigation.navigationBar.prefersLargeTitles = true
        navigation.pushViewController(view, animated: true)
    }
    
    func pushSourceView(category: NewsCategories) {
        let router = SourceRouter(navigation, title: category.rawValue.capitalized)
        router.category = category
        router.start()
    }
    
    
}
