//
//  PlantCollectionViewCell.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import UIKit

class PlantCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PlantCollectionViewCell"
    
    var planetId: String?
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        
        containerView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    func configure(planet: Planet) {
        titleLabel.text = "NASA"
        planetId = planet.title
        
        imageView.image = UIImage(systemName: "globe")
        
        ImageLoader.shared.loadImage(from: planet.url) { [weak self] result in
            if self?.planetId == planet.title {
                DispatchQueue.main.async {
                    switch result {
                    case .success(let image):
                        self?.titleLabel.text = self?.planetId
                        self?.imageView.image = image
                    case .failure(let error):
                        let alert = UIAlertController(title: "Error", message: "Failed to load image: \(error)", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                            if let navigationController = self?.window?.rootViewController as? UINavigationController {
                                navigationController.popViewController(animated: true)
                            }
                        }))
                        self?.window?.rootViewController?.present(alert, animated: true, completion: nil)
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
