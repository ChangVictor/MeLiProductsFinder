//
//  SearchResult.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 22/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    
    let paging: Paging?
    let results: [ItemResult]?
}
