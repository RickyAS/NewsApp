//
//  ArticleController.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import UIKit

class ArticleController: UIViewController {
    @IBOutlet weak var mainTable: UITableView!
    lazy var searchControl = UISearchController()
    var presenter: ArticlePresenterProtocol!
    let cellId = "ArticleCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        mainTable.dataSource = self
        mainTable.delegate = self
        mainTable.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        mainTable.rowHeight = UITableView.automaticDimension
        mainTable.estimatedRowHeight = 100
        navigationItem.searchController = searchControl
        navigationItem.hidesSearchBarWhenScrolling = false
        searchControl.searchBar.delegate = self
        searchControl.searchBar.placeholder = "More from \(navigationItem.title ?? "")"
        presenter.getArticles(isReload: true)
        presenter.onFinish = { [weak self] in
            self?.mainTable.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }

}

extension ArticleController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getArticlesSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ArticleCell
        let item = presenter.getArticle(row: indexPath.row)
        cell.setup(article: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == presenter.getArticlesSize()-1 && indexPath.row > 6 {
            if !presenter.searchText.isEmpty {
                presenter.searchArticle(isReload: false)
            } else {
                presenter.getArticles(isReload: false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openWebArticle(row: indexPath.row)
    }
}

extension ArticleController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            presenter.searchText = searchText
            presenter.searchArticle(isReload: true)
        } else {
            presenter.getArticles(isReload: true)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            presenter.searchText = searchText
            presenter.searchArticle(isReload: true)
        } else {
            presenter.getArticles(isReload: true)
        }
    }
}
