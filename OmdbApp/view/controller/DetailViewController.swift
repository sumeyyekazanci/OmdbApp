//
//  DetailViewController.swift
//  OmdbApp
//
//  Created by Sümeyye Kazancı on 2.11.2022.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Lightning Mcqueen"
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
//        label.text = "Cars 3"
        return label
    }()
    
    private let imdbImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "imdb")
        
        imageView.layer.cornerRadius = 5
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemYellow
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let rateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .gray
        label.text = "3"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rate10Label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.text = "/10"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dotImage: UIImageView = {
        let imageView = UIImageView()
        let configuration = UIImage.SymbolConfiguration(pointSize: 5)
        imageView.image = UIImage(systemName: "circle.fill",withConfiguration: configuration)
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemYellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.text = "06.10.2022"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = "Geri"
        backButton.tintColor = .label
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        
//        scrollView.contentSize = CGSize(width: view.frame.size.width, height: view.frame.size.height * 2)
        scrollView.addSubview(movieImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(overviewLabel)
        
        stack.addArrangedSubview(imdbImage)
        stack.addArrangedSubview(starImage)
        stack.addArrangedSubview(rateLabel)
        stack.addArrangedSubview(rate10Label)
        stack.addArrangedSubview(dotImage)
        stack.addArrangedSubview(dateLabel)
        scrollView.addSubview(stack)
        
        configureConstraints()
        
    }
    
    func configureConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        let contentLayoutGuide = scrollView.contentLayoutGuide
        
        let scrollViewConstraints = [
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ]
        
        let movieImageConstraints = [
            movieImageView.topAnchor.constraint(equalTo: contentLayoutGuide.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalToConstant: 300)
        ]
        
        let stackConstraints = [
            stack.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            stack.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 10),
            stack.heightAnchor.constraint(equalToConstant: 25)
        ]
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
        ]
        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            overviewLabel.bottomAnchor.constraint(equalTo: contentLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollViewConstraints)
        NSLayoutConstraint.activate(movieImageConstraints)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(stackConstraints)
        
    }
    
    public func configure(with model: MovieDetailViewModel) {
        titleLabel.text = model.title
        overviewLabel.text = model.plot
        let date = model.released.formatDate
        dateLabel.text = date
        rateLabel.text = model.rated
        
        guard let url = URL(string: model.poster) else {
            return
        }
        
        movieImageView.kf.indicatorType = .activity
        movieImageView.kf.setImage(with: url)
        
        Analytics.logEvent(Constants.movieTitle, parameters: [Constants.movieTitleParametersName : model.title])
        Analytics.logEvent(Constants.movieRate, parameters: [Constants.movieRateParametersName : model.rated])
        Analytics.logEvent(Constants.movieReleaseDate, parameters: [Constants.movieReleaseDateParametersName : model.released])
    }
}
