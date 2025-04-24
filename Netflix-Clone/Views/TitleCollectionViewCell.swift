//
//  TitleCollectionViewCell.swift
//  Netflix-Clone
//
//  Created by Shamanth R on 19/04/25.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifer = "TitleCollectionViewCell"
    let baseURL = "https://image.tmdb.org/t/p/w500/"
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTitleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    private func setUpTitleView() {
        contentView.addSubview(posterImageView)
    }
    
    public func configure(with model: String) {
        guard let url = URL(string: "\(baseURL)\(model)") else { return }
        posterImageView.sd_setImage(with: url, completed: nil)
    }
    
}
