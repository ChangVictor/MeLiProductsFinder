//
//  ItemResult.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 27/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

struct ItemResult: Decodable {
    
    let id: String
    let site_id: String
    let title: String
    let price: Double
    let available_quantity: Int
    let sold_quantity: Int
    let condition: String
    let permalink: String
    let thumbnail: String
    let accepts_mercadopago: Bool
    let installments: Installment?
    let address: Address?
    let shipping: Shipping?
}
