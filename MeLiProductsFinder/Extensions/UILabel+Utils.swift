//
//  Extensions.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 22/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, textColor: UIColor = .black, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.numberOfLines = numberOfLines
    }
}
