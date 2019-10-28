//
//  SearchResultCell.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 22/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    var itemViewModel: ItemViewModel! {
        didSet {
            titleLabel.text = itemViewModel.title
            priceLabel.text = itemViewModel.price
            isNewLabel.text = itemViewModel.condition
            shippingLabel.text = itemViewModel.hasFreeShipping
            imageView.loadImage(fromUrl: itemViewModel.thumbnail)
        }
    }
 
    let imageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .meliWhite
        return imageView
    }()

    let titleLabel: UILabel = {
        
        let label = UILabel()
        label.text = "Item Name"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .meliBlack
        label.numberOfLines = 5
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$ 0.00"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.numberOfLines = 1
        return label
    }()
    
    let isNewLabel: UILabel = {
        let label = UILabel()
        label.text = "Usado"
        label.textColor = .meliGrey
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    
    let shippingLabel: UILabel = {
        let label = UILabel()
        label.text = "Envio Gratis"
        label.textColor = .meliGreen
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .meliWhite
        setupViews()
    }
    
    fileprivate func setupViews() {
        imageView.constrainWidth(constant: 130)
        imageView.constrainHeight(constant: 130)
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [titleLabel, priceLabel, isNewLabel, shippingLabel], spacing: 5)])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
