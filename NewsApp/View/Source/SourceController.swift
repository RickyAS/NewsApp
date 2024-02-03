//
//  SourceController.swift
//  NewsApp
//
//  Created by amartek on 02/02/24.
//

import UIKit

class SourceController: UIViewController {
    @IBOutlet weak var mainTable: UITableView!
    lazy var searchControl = UISearchController()
    var presenter: SourcePresenterProtocol!
    let cellId = "SourceCell"
    
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
        searchControl.searchBar.placeholder = "Find Sources"
        presenter.getSources { [weak self] in
            self?.mainTable.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension SourceController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.getSourcesSize()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! SourceCell
        let item = presenter.getSource(row: indexPath.row)
        cell.setup(source: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.openNewsArticle(row: indexPath.row)
    }
}

extension SourceController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchSource(text: searchBar.text ?? "") { [weak self] in
            self?.mainTable.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchSource(text: searchBar.text ?? "") { [weak self] in
            self?.mainTable.reloadData()
        }
    }
}
