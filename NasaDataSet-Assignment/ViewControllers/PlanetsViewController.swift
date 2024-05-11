//
//  PlanetsViewController.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import UIKit

class PlanetsViewController: UIViewController {
    
    var viewModel = ViewModel()
        
    let collectionView = PlanetsCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        
        bindViewModel()
        
        viewModel.fetchPlanets()
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func bindViewModel() {
        viewModel.$planets
            .receive(on: DispatchQueue.main)
            .sink { [weak self] planets in
                self?.collectionView.planets = planets
            }
            .store(in: &viewModel.cancellables)
    }
    
}

