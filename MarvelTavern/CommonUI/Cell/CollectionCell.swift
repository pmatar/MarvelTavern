//
//  CollectionCell.swift
//  MarvelTavern
//
//  Created by Paul Matar on 24/12/2022.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    
    private lazy var imageView: AsyncImageView = {
        let iv = AsyncImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont(name: C.Fonts.marvelFont, size: 20)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configure(with model: HeroItem) {
        switch model {
        case .loading(_):
            showLoading()
        case .heroes(let hero):
            nameLabel.text = hero.name
            let placeholder = UIImage(named: C.Images.placeholder)
            imageView.setImage(hero.thumbnail?.stringUrl, placeholder: placeholder)
        }
    }
    
    func configure(with model: DetailsItem) {
        switch model {
        case .loading(_):
            showLoading()
        case .details(let detail):
            nameLabel.text = detail.title
            let placeholder = UIImage(named: C.Images.placeholder)
            imageView.setImage(detail.thumbnail?.stringUrl, placeholder: placeholder)
        }
    }
    
    private func showLoading() {
        let marvelRed = UIColor(named: C.Colors.marvelRed) ?? .red
        contentView.shimmer(with: marvelRed)
    }
    
    private func layoutViews() {
        imageView.place(on: contentView).pin(
            .top,
            .trailing,
            .leading,
            .height(to: contentView, padding: -30)
        )
        
        nameLabel.place(on: contentView).pin(
            .top(to: imageView, .bottom, padding: 10),
            .trailing,
            .leading
        )
    }
}
