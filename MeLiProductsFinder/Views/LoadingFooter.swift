//
//  LoadingFooter.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 25/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class LoadingFooter: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let style = UIActivityIndicatorView.Style.medium
        let activityIndicatiorView = UIActivityIndicatorView(style: style)
        activityIndicatiorView.color = .meliGrey
        activityIndicatiorView.startAnimating()
        
        let label = UILabel(text: "Cargando resultados...", font: .systemFont(ofSize: 14))
        label.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubviews: [
            activityIndicatiorView, label ], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
