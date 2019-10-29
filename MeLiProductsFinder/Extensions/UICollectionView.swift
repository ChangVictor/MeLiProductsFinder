//
//  UICollectionView.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 28/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import UIKit

extension UICollectionView {

    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        
        return indexPath.section < numberOfSections && indexPath.row < numberOfItems(inSection: indexPath.section)
    }
    
    func scrollToTop(_ animated: Bool = false) {
        
        let indexPath = IndexPath(row: 0, section: 0)
        if hasRowAtIndexPath(indexPath: indexPath) {
            scrollToItem(at: indexPath, at: .top, animated: animated)
        }
    }
}
