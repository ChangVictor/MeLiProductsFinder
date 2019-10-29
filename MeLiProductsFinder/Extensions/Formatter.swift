//
//  Formatter.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 27/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

extension Formatter {
    
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.groupingSeparator = "."
        formatter.numberStyle = .decimal
        return formatter
    }()
}
