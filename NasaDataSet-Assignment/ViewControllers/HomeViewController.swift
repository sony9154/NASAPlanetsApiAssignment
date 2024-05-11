//
//  ViewController.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import UIKit

class HomeViewController: UIViewController {

    private let requestButton: UIButton = {
        let button = UIButton()
        button.setTitle("Request", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Astronomy Picture of the Day"
        label.font = UIFont(name: "PingFangTC-Medium", size: 21)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupRequestButton()
        setupTitleLabel()

        requestButton.addTarget(self, action: #selector(requestButtonTapped), for: .touchUpInside)
    }
    
    func setupRequestButton() {
        view.addSubview(requestButton)
        NSLayoutConstraint.activate([
            requestButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            requestButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            requestButton.widthAnchor.constraint(equalToConstant: 200),
            requestButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupTitleLabel() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: requestButton.topAnchor, constant: -100)
        ])
    }
    
    @objc private func requestButtonTapped() {
        let planetsVC = PlanetsViewController()
        navigationController?.pushViewController(planetsVC, animated: true)
    }
    
}

