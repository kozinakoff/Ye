//
//  ViewController.swift
//  Ye
//
//  Created by ANDREY VORONTSOV on 24.10.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var quoteLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var refreshButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .red
        button.layer.cornerRadius = 10
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.setTitle("More!", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchQuote()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        view.addSubview(quoteLabel)
        view.addSubview(refreshButton)
        
        refreshButton.addTarget(self, action: #selector(refreshQuote), for: .touchUpInside)
        
        let padding: CGFloat = 16
        NSLayoutConstraint.activate([
            quoteLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            quoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            quoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            quoteLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            refreshButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -60),
            refreshButton.heightAnchor.constraint(equalToConstant: 44),
            refreshButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            refreshButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            refreshButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func fetchQuote() {
        NetworkManager.shared.getKanyeQuote { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let quote):
                DispatchQueue.main.async {
                    self.quoteLabel.text = quote.quote
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
                    self.present(alert, animated: true, completion: nil)
                }
            }
        }
    }
    
    @objc private func refreshQuote() {
        fetchQuote()
    }
}
