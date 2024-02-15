//
//  WorkCell.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 15.02.2024.
//

import UIKit

final class WorkCell: UICollectionViewCell {
    
    private let workImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        workImageView.image = nil
    }
    
    
    public func setupCell(work: Work) {
        workImageView.image = UIImage(named: work.image)
    }
    
    private func setupLayout() {
        contentView.addSubview(workImageView)
        
        NSLayoutConstraint.activate([
            workImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            workImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            workImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            workImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
