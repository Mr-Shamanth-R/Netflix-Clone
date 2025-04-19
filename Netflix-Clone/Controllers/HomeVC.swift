//
//  HomeVC.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 16/04/25.
//

import UIKit

class HomeVC: UIViewController {
    
    let sectionTitles: [String] = ["Trending movies", "Trending Tv", "Popular", "Upcoming movies", "Top rated"]
    
    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setUpHomeView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    private func setUpHomeView() {
        setUpTablewView()
        setUpNavBar()
        getTrendingMovies()
        getTrendingTVShows()
        getUpComingMovies()
        getUpComingMovies()
        getPopularMovies()
    }
    
    private func setUpTablewView() {
        view.addSubview(homeFeedTable)
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        setUpTableHeaderView()
    }
    
    private func setUpTableHeaderView() {
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func setUpNavBar() {
        let image = UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMoveis { results in
            switch results {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getTrendingTVShows() {
        APICaller.shared.getTrendingTVShows { results in
            switch results {
            case .success(let tv):
                print(tv)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getUpComingMovies() {
        APICaller.shared.getUpComingMovies { results in
            switch results {
            case .success(let upcoming):
                print(upcoming)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getPopularMovies() {
        APICaller.shared.getPopularMovies { results in
            switch results {
            case .success(let popular):
                print(popular)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func getTopRatedMovies() {
        APICaller.shared.getTopRatedMovies { results in
            switch results {
            case .success(let topRated):
                print(topRated)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = homeFeedTable.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 15, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.captializeFirstLetter()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
