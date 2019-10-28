//
//  Installment.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 27/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

struct Installment: Decodable {
    
    let quantity: Int
    let amount: Double
    let rate: Double
}

struct Shipping: Decodable {
    let free_shipping: Bool
}
