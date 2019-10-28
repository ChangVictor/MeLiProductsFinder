//
//  Paging.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 27/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

struct Paging: Decodable {
    
    let total: Int?
    let offset: Int?
    let limit: Int?
    let primaryResults: Int?
}
