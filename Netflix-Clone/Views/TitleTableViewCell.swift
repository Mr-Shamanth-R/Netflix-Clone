//
//  TitleTableViewCell.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 19/04/25.
//

import UIKit

class TitleTableViewCell: UITableViewCell {
    
    static let identifier = "TitleTableViewCell"
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    
    var title: TitlePreviewViewModel?
    
    private let titlePosterImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let playButton: UIButton = {
      let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setpTitleTableView()
        playButton.addTarget(self, action: #selector(openVideoInExternalBrowser), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setpTitleTableView() {
        contentView.addSubview(titlePosterImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            titlePosterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlePosterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titlePosterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            titlePosterImageView.widthAnchor.constraint(equalToConstant: 100),
            
            titleLabel.leadingAnchor.constraint(equalTo: titlePosterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
    
    public func configureTitlePreviewViewModel(with model: TitlePreviewViewModel) {
        title = model
    }
    
    public func configure(with model: TitleViewModel) {
        guard let url = URL(string: "\(baseURL)\(model.posterURL)") else { return }
        titlePosterImageView.sd_setImage(with: url)
        titleLabel.text = model.titleName
    }
    
    @objc private func openVideoInExternalBrowser() {
        guard let id = title?.youtubeView.id.videoId,
         let url = URL(string: "https://www.youtube.com/embed/\(id)") else { return }
        UIApplication.shared.open(url)
    }

}
