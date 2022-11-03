//
//  HomeViewController.swift
//  OmdbApp
//
//  Created by Sümeyye Kazancı on 1.11.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    let searchController = UISearchController()
    let api: OmdbAPIProtocol = OmdbAPI()
    private var movies: [SearchedMovie] = [SearchedMovie]()
    
    let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.contentInsetAdjustmentBehavior = .never
        table.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search Movie"
        
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.isUserInteractionEnabled = false
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
        configConstraints()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func configConstraints() {
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.widthAnchor.constraint(equalToConstant: view.frame.size.width),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(tableViewConstraints)
    }
    
    private func alert() {
        let alert = UIAlertController(title: "Alert", message: "No result found", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
}

extension HomeViewController: UISearchBarDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        print(text)
        
        if text.count >= 3 {
            api.getMovies(searchText: text) { [weak self] result in
                switch result {
                    
                case .success(let data):
                    print(data.Search)
                    self?.movies = data.Search
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                   
                case .failure(_):
//                    print(error.localizedDescription)
                    self?.movies = []
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                    self?.alert()
                }
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movie = movies[indexPath.row]
        cell.configure(with: MovieViewModel(title: movie.title ?? "", year: movie.year ?? "", imdbID: movie.imdbID ?? "", type: movie.type ?? "", poster: movie.poster ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let movie = movies[indexPath.row]
        
        guard let id = movie.imdbID else {
            return
        }
        
        api.getMovieDetails(id: id) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let vc = DetailViewController()
                    vc.title = data.title
                    vc.configure(with: MovieDetailViewModel(title: data.title, year: data.released, poster: data.poster, genre: data.genre, runtime: data.runtime, director: data.director, actors: data.actors, plot: data.plot, released: data.released, rated: data.rated, language: data.language))
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
