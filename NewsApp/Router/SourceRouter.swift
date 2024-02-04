//
//  SourceRouter.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation
import UIKit

protocol SourceRouterProtocol {
    func presentAlert(message: String)
    func pushArticleView(sourceId: String, sourceName: String)
}

class SourceRouter: BaseRouterProtocol, SourceRouterProtocol {
    let title: String
    let navigation: UINavigationController
    var category: NewsCategories!
    
    required init(_ navigation: UINavigationController, title: String) {
        self.navigation = navigation
        self.title = title
    }
    
    func start() {
        let view = SourceController(nibName: nil, bundle: nil)
        view.presenter = SourcePresenter(category: category, interactor: SourceInteractor(), router: self)
        view.navigationItem.title = title
        navigation.pushViewController(view, animated: true)
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Something's wrong", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        navigation.viewControllers.last?.present(alert, animated: true)
    }
    
    func pushArticleView(sourceId: String, sourceName: String) {
        let router = ArticleRouter(navigation, title: sourceName)
        router.sourceId = sourceId
        router.start()
    }
}
