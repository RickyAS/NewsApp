//
//  HomeController.swift
//  NewsApp
//
//  Created by Ricky Austin on 01/02/24.
//

import UIKit

enum NewsCategories: String {
    case business, entertainment, general, health, sports, technology
    
    var icon: String {
        switch self {
        case .business: "dollarsign.circle"
        case .entertainment: "party.popper"
        case .general: "newspaper"
        case .health: "heart"
        case .sports: "figure.soccer"
        case .technology: "network"
        }
    }
    
    var backColor: UIColor {
        switch self {
        case .business: .systemGreen
        case .entertainment: .systemPurple
        case .general: .systemOrange
        case .health: .systemPink
        case .sports: .systemMint
        case .technology: .systemCyan
        }
    }
}

class HomeController: UIViewController {
    @IBOutlet weak var mainCollection: UICollectionView!
    var presenter: HomePresenterProtocol!
    let cellId = "HomeCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainCollection.delegate = self
        mainCollection.dataSource = self
        mainCollection.register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
}

extension HomeController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter.getCategorySize()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let length = (collectionView.frame.width/2) - 18
        return CGSize(width: length, height: length)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeCell
        let item = presenter.getCategory(row: indexPath.row)
        cell.setup(category: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.openNewsSource(row: indexPath.row)
    }
}
