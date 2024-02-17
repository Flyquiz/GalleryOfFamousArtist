//
//  ViewController.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 13.02.2024.
//

import UIKit

//MARK: - ViewController
final class ViewController: UIViewController {
    
    private let modelData = ModelData()
    
    private var filteredResults = [Artist]()
    
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ArtistCell.self, forCellWithReuseIdentifier: ArtistCell.identifier)
        return collectionView
    }()
    
    private lazy var searchController: UISearchController = {
        let searchVC = UISearchController()
        searchVC.delegate = self
        searchVC.searchBar.delegate = self
        searchVC.searchResultsUpdater = self
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.definesPresentationContext = true
        searchVC.searchBar.placeholder = "Find Artist"
        return searchVC
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationBar()
    }

    
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        view.addSubview(mainCollectionView)
        
        NSLayoutConstraint.activate([
            mainCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Gallery of Famous Artist"
        navigationItem.searchController = searchController
    }
}


//MARK: - CollectionView dataSource/delegate
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredResults.count
        } else {
            return modelData.artists.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var artist: Artist
        if isFiltering {
            artist = filteredResults[indexPath.item]
        } else {
            artist = modelData.artists[indexPath.item]
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistCell.identifier, for: indexPath) as! ArtistCell
        cell.setupCell(artist)
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    private var inset: CGFloat { 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (collectionView.bounds.height - inset * 6) / 2.5
        let width = collectionView.bounds.width - inset * 2
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var artist: Artist
        if isFiltering {
            artist = filteredResults[indexPath.item]
        } else {
            artist = modelData.artists[indexPath.item]
        }
        
        let detailVC = DetailArtistViewController(artist: artist)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


//MARK: - SearchController delegates
extension ViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if filteredResults.count == 1 {
            let detailVC = DetailArtistViewController(artist: filteredResults.first!)
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}

extension ViewController: UISearchResultsUpdating {
    
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    private func filterContentForSearchText(_ searchText: String) {
        filteredResults = modelData.artists.filter({ (artist: Artist) -> Bool in
            artist.name.lowercased().contains(searchText.lowercased())
        })
        
        mainCollectionView.reloadData()
    }
}
