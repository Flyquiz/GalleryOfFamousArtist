//
//  ArtistCell.swift
//  GalleryOfFamousArtist
//
//  Created by Иван Захаров on 13.02.2024.
//

import UIKit

final class ArtistCell: UICollectionViewCell {
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.preferredMaxLayoutWidth = 0
        return label
    }()
    
    private let artistImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
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
        nameLabel.text = nil
        descriptionLabel.text = nil
        artistImageView.image = nil
    }
    
    private func setupLayout() {
        contentView.backgroundColor = .systemGray5
        [nameLabel,
         descriptionLabel,
         artistImageView].forEach { contentView.addSubview($0) }
        
        let imageSize: CGFloat = 100
        let cellInset: CGFloat = 10
        
        nameLabel.setContentHuggingPriority(.defaultHigh + 1, for: .vertical)
        NSLayoutConstraint.activate([
            artistImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellInset),
            artistImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: cellInset),
            artistImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -cellInset),
            artistImageView.widthAnchor.constraint(equalToConstant: imageSize),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: cellInset),
            nameLabel.leadingAnchor.constraint(equalTo: artistImageView.trailingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -cellInset),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: artistImageView.bottomAnchor)
        ])
    }
    
    public func setupCell(_ artist: Artist) {
        nameLabel.text = artist.name
        descriptionLabel.text = artist.bio
        artistImageView.image = UIImage(named: artist.image)
    }
}
