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

    let titleLabel = UILabel(text: "Item Name", font: UIFont.systemFont(ofSize: 16, weight: .medium), textColor: .meliBlack, numberOfLines: 5)
    
    let priceLabel = UILabel(text: "$ 0.00", font: UIFont.systemFont(ofSize: 18, weight: .semibold), textColor: .meliBlack, numberOfLines: 1)
    
    let isNewLabel = UILabel(text: "Condicion", font: UIFont.systemFont(ofSize: 12, weight: .light), textColor: .meliGrey)
    
    let shippingLabel = UILabel(text: "Envio Gratis", font: UIFont.systemFont(ofSize: 12, weight: .regular), textColor: .meliGreen)
    
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
