//
//  DetailViewController.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 15.02.2024.
//

import UIKit

final class DetailViewController: UIViewController {
    
    private var artistWorks: [Work]?
    
    private lazy var mainCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(WorkCell.self, forCellWithReuseIdentifier: WorkCell.identifier)
        collectionView.flashScrollIndicators()
        return collectionView
    }()
    
    private let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        return label
    }()
    
    private let aboutLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "About this artist:"
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18)
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private let artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        //        imageView.backgroundColor = .systemGray4
        return imageView
    }()
    
    private let worksLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Artist's work:"
        label.font = .systemFont(ofSize: 16, weight: .thin)
        return label
    }()
    
    
    
    
    convenience init(artist: Artist) {
        self.init()
        self.artistWorks = artist.works
        nameLabel.text = artist.name
        descriptionLabel.text = artist.bio
        artistImageView.image = UIImage(named: artist.image)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        [mainCollectionView,
         nameLabel,
         aboutLabel,
         descriptionLabel,
         artistImageView,
         worksLabel].forEach { contentView.addSubview($0) }
        
        
        let inset: CGFloat = 20
        
        NSLayoutConstraint.activate([
            mainScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: mainScrollView.widthAnchor),
            
            
            artistImageView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            artistImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            artistImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            artistImageView.heightAnchor.constraint(equalToConstant: 300),
            
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: artistImageView.bottomAnchor, constant: inset),
            
            aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: inset * 2),
            aboutLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            
            descriptionLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: inset / 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            descriptionLabel.widthAnchor.constraint(equalToConstant: descriptionLabel.intrinsicContentSize.width),
            
            worksLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: inset * 2),
            worksLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            
            mainCollectionView.topAnchor.constraint(equalTo: worksLabel.bottomAnchor, constant: inset / 2),
            mainCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            mainCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            mainCollectionView.heightAnchor.constraint(equalToConstant: 300),
            mainCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            
            
        ])
    }
}



extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        artistWorks?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkCell.identifier, for: indexPath) as! WorkCell
        guard let work = artistWorks?[indexPath.item] else { fatalError("Can't create a cell: WorkCell")
        }
        cell.setupCell(work: work)
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    var inset: CGFloat { 20 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height
        let width = (collectionView.bounds.width) / 2
        return CGSize(width: width, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return inset
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        inset
    }
}
