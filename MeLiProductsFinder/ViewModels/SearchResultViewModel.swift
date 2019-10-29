//
//  SearchResultViewModel.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 26/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

class SearchResultViewModel {
    
    private var timer: Timer?
    fileprivate var resultQuantity = 0
    fileprivate var itemsResult = [ItemResult]()    
    fileprivate var itemViewModel = [ItemViewModel]()

    var isSearchTextFieldValid: ((String?) -> Void)?
    var onItemsFetched: (([ItemViewModel]?, Int?) -> Void)?
    var onFetchError: ((Error?) -> Void)?
    var onEmptySearchTerm: (() -> Void)?
    
    var searchTerm: String? {
        didSet {
            isSearchTextFieldValid?(searchTerm)
        }
    }
    
    func shouldTriggerSearch(_ searchTerm: String?) {
        guard let isSearchEmpty = searchTerm?.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        guard let searchCount = searchTerm?.count else { return }

        if !isSearchEmpty && searchCount >= 3 {
            print("item fetching triggered : \(searchTerm ?? "")")
            fetchItemsFromService(self.searchTerm!)
        }
        self.onEmptySearchTerm?()
    }
    
    func fetchItemsFromService(_ searchTerm: String, completion: (() -> Void)? = nil) {
        Service.shared.fetchItems(searchTerm: searchTerm) { (response, error) in
            if let error = error {
                Logger.print("Failed to fetch items: ", error)
                self.onFetchError?(error)
                return
            }
            
            self.resultQuantity = response?.paging?.total ?? 0
            self.itemViewModel = response?.results?.map({ return ItemViewModel(item: $0)}) ?? []
            Logger.print(response as Any)
            self.onItemsFetched?(self.itemViewModel, self.resultQuantity)
            completion?()
        }
    }
    
    func paginateMoreItems(_ searchTerm: String, completion: (([ItemViewModel]?) -> Void)? = nil) {
        
        Service.shared.fetchItems(searchTerm: searchTerm) { (response, error) in
                    if let error = error {
                        Logger.print("Failed to fetch items: ", error)
                        self.onFetchError?(error)
                        return
                    }
                    completion?(self.itemViewModel)
                }
    }
}


