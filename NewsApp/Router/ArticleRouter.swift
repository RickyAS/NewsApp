//
//  ArticleRouter.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import Foundation
import UIKit

protocol ArticleRouterProtocol {
    func presentAlert(message: String)
    func pushWebArticleView(urlString: String)
}

class ArticleRouter: BaseRouterProtocol, ArticleRouterProtocol {
    var title: String
    var navigation: UINavigationController
    var sourceId: String!
    
    required init(_ navigation: UINavigationController, title: String) {
        self.navigation = navigation
        self.title = title
    }
    
    func start() {
        let view = ArticleController(nibName: nil, bundle: nil)
        view.presenter = ArticlePresenter(sourceId: sourceId, interactor: ArticleInteractor(), router: self)
        view.navigationItem.title = title
        navigation.navigationBar.prefersLargeTitles = false
        navigation.pushViewController(view, animated: true)
    }
    
    func presentAlert(message: String) {
        let alert = UIAlertController(title: "Something's wrong", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel)
        alert.addAction(action)
        navigation.viewControllers.last?.present(alert, animated: true)
    }
    
    func pushWebArticleView(urlString: String) {
        let view = ArticleWebController(nibName: nil, bundle: nil)
        view.urlString = urlString
        navigation.pushViewController(view, animated: true)
    }
    
}
