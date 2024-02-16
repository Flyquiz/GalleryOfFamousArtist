//
//  DetailWorkViewController.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 15.02.2024.
//

import UIKit

final class DetailWorkViewController: UIViewController {
    
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let workImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    convenience init(work: Work) {
        self.init()
        titleLabel.text = work.title
        infoLabel.text = work.info
        workImageView.image = UIImage(named: work.image)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemGray6
        
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(contentView)
        
        [titleLabel,
        infoLabel,
         workImageView].forEach { contentView.addSubview($0) }
        
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
            
            
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            workImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            workImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            workImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            workImageView.heightAnchor.constraint(equalToConstant: workImageView.intrinsicContentSize.height),
            
            infoLabel.topAnchor.constraint(equalTo: workImageView.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            infoLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
