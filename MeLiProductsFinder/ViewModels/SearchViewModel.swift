//
//  SearchViewModel.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 26/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

class SearchViewModel {
    
    var isValid: ((Bool) -> Void)?
    
    var searchTerm: String? {
        didSet {
            checkTextFieldValidity()
        }
    }
    
    func checkTextFieldValidity() {
        
        let isValid = searchTerm?.trimmingCharacters(in: .whitespaces).isEmpty == false
        self.isValid?(isValid)
    }

}
