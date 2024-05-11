//
//  DetailsViewController.swift
//  NasaDataSet-Assignment
//
//  Created by Hsu Hua on 2024/4/25.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var planet: Planet? {
        didSet {
            dateLabel.text = planet?.formattedDate
            descLabel.text = planet?.description
            titleLabel.text = planet?.title
            copyRightLabel.text = planet?.copyright
            loadImage()
            updateContentHeight()
        }
    }
    
    private let fogView: UIView = {
       let view = UIView()
        let color = #colorLiteral(red: 0.1803921569, green: 0.177393347, blue: 0.1720119417, alpha: 0.9176324503)
        view.backgroundColor = color
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let loadingLabel: UILabel = {
        let label = UILabel()
        label.text = "Loading Image"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let hdImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .blue
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private let copyRightLabel: UILabel = {
        let label = UILabel()
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let descContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let descLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupScrollView()
    }
    
    func setupScrollView() {
        let margins = view.layoutMarginsGuide
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        view.addSubview(fogView)
        view.addSubview(activityIndicator)
        view.addSubview(loadingLabel)
        
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        loadingLabel.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor).isActive = true
        loadingLabel.bottomAnchor.constraint(equalTo: activityIndicator.topAnchor, constant: -20).isActive = true

        fogView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        fogView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        fogView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        fogView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        configureContainerView()
    }
    
    private func configureContainerView() {
        
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(hdImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(copyRightLabel)
        descContainerView.addSubview(descLabel)

        NSLayoutConstraint.activate([
            descLabel.leadingAnchor.constraint(equalTo: descContainerView.leadingAnchor, constant: 10),
            descLabel.trailingAnchor.constraint(equalTo: descContainerView.trailingAnchor, constant: -10),
            descLabel.topAnchor.constraint(equalTo: descContainerView.topAnchor),
            descLabel.bottomAnchor.constraint(equalTo: descContainerView.bottomAnchor)
        ])
        
        stackView.addArrangedSubview(descContainerView)
        stackView.distribution = .equalSpacing
        
        updateContentHeight()
    }
    
    private func updateContentHeight() {
        scrollView.contentSize = CGSize(width: view.frame.width, height: stackView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height)
    }
    
    private func loadImage() {
        guard let hdUrl = planet?.hdurl else { return }
        
        activityIndicator.startAnimating()
        self.fogView.isHidden = false
        self.loadingLabel.isHidden = false
        ImageLoader.shared.loadImage(from: hdUrl) { [weak self] result in
            DispatchQueue.main.async {
                self?.fogView.isHidden = true
                self?.activityIndicator.stopAnimating()
                self?.loadingLabel.isHidden = true
                
                switch result {
                case .success(let image):
                    self?.hdImageView.image = image
                    let aspectRatio = image.size.width / image.size.height
                    let imageViewHeight = (self?.view.frame.width ?? 0) / aspectRatio
                    self?.hdImageView.heightAnchor.constraint(equalToConstant: imageViewHeight).isActive = true
                    self?.updateContentHeight()
                    
                case .failure(let error):
                    print("Error loading image: \(error)")
                }
            }
        }
    }
}
