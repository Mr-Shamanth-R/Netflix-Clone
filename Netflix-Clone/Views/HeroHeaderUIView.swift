//
//  HeroHeaderUIView.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 18/04/25.
//

import UIKit
import SDWebImage

class HeroHeaderUIView: UIView {
    
    let baseURL = "https://image.tmdb.org/t/p/w500/"
        
    private var titles: [Title] = []
        
    private let playButton: UIButton = {
       let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let downloadButton: UIButton = {
       let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let heroImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "heroImage")
        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpHeaderView()
    }
    
    public func configureHeroImageView(with posterString: String) {
        guard let url = URL(string: "\(baseURL)\(posterString)") else { return }
        heroImageView.sd_setImage(with: url)
    }
    
    public func updateTitlesForDownload(with title: Title) {
        titles.append(title)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    private func setUpHeaderView() {
        addSubview(heroImageView)
        addGradiant()
        addSubview(playButton)
        addSubview(downloadButton)
        playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        downloadButton.addTarget(self, action: #selector(downloadTitle), for: .touchUpInside)
        addConstraints()
    }
    
    @objc private func downloadTitle() {
        guard let title = titles.first else { return }
        DataPersistenceManager.shared.downloadTitle(with: title) { result in
            switch result {
            case .success():
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    @objc private func didTapPlayButton() {
        guard let title = titles.first else { return }
        guard let titleName = title.original_title ?? title.original_name else { return }
        APICaller.shared.getMovieTrailers(with: titleName + "trailer") { result in
            switch result {
            case .success(let videoElement):
                if let url = URL(string: "https://www.youtube.com/embed/\(videoElement.id.videoId)") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addGradiant() {
        let gradiant = CAGradientLayer()
        gradiant.colors = [UIColor.clear.cgColor, UIColor.systemBackground.cgColor]
        gradiant.frame = bounds
        layer.addSublayer(gradiant)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            playButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 65),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 120),
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -65),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
}
