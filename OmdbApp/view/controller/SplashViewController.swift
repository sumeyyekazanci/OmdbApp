//
//  SplashViewController.swift
//  OmdbApp
//
//  Created by Sümeyye Kazancı on 2.11.2022.
//

import UIKit

class SplashViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Title"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        configConstraints()
        
        FirebaseManager.shared.fetchValues(with: titleLabel)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapLabel(_:)))
        titleLabel.isUserInteractionEnabled = true
        titleLabel.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func didTapLabel(_ gesture: UITapGestureRecognizer) {
        print("tapped")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3 ) {
            //MARK: go HomeViewController
            let homeVC = HomeViewController()
            self.navigationController?.pushViewController(homeVC, animated: true)
        }
    }
    
    private func configConstraints() {
        let titleConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(titleConstraints)
    }
}
