//
//  PlanetsCollectionView.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import UIKit

class PlanetsCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var planets: [Planet] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 1
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.register(PlantCollectionViewCell.self, forCellWithReuseIdentifier: PlantCollectionViewCell.identifier)
        self.dataSource = self
        self.delegate = self
        self.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: self.topAnchor),
            self.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PlantCollectionViewCell.identifier, for: indexPath) as? PlantCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let planet = planets[indexPath.row]
        cell.configure(planet: planet)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 6) / 4
        let height = width
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PlantCollectionViewCell, cell.titleLabel.text != "NASA" else {
            return
        }
        
        let detailsVC = DetailsViewController()
        if let navigationController = self.window?.rootViewController as? UINavigationController {
            detailsVC.planet = self.planets[indexPath.row]
            navigationController.pushViewController(detailsVC, animated: true)
        }
    }
}
