//
//  DetailWorkViewController.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 15.02.2024.
//

import UIKit

final class DetailWorkViewController: UIViewController {
    
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
        
        [titleLabel,
        infoLabel,
         workImageView].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            workImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            workImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            workImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            workImageView.heightAnchor.constraint(equalToConstant: workImageView.intrinsicContentSize.height),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: workImageView.topAnchor, constant: -20),
            
            infoLabel.topAnchor.constraint(equalTo: workImageView.bottomAnchor, constant: 20),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
