//
//  ResultsHeader.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 25/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

class ResultsHeader: UICollectionReusableView {
    
    var resultsQuantity: Int? {
        didSet {
            setupAmount()
        }
    }
    
    let resultLabel: UILabel = {
        let resultsAmountLabel = UILabel(text: "123 resultados", font: UIFont.systemFont(ofSize: 14, weight: .regular))
        resultsAmountLabel.textAlignment = .left
        resultsAmountLabel.textColor = .meliGrey
        return resultsAmountLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .meliWhite
        
        addSubview(resultLabel)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 1
        resultLabel.anchor(top: topAnchor, left: self.safeAreaLayoutGuide.leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 0, width: 0, height: 0)
        resultLabel.centerXInSuperview()
    }
        
    fileprivate func setupAmount() {
        guard let results = resultsQuantity else { return }
        resultLabel.text = results < 2000 ? "\(results.formattedWithSeparator) resultados" : "+2.000 resultados"
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
