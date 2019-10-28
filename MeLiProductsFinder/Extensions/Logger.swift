//
//  Logger.swift
//  MeLiProductsFinder
//
//  Created by Victor Chang on 22/10/2019.
//  Copyright © 2019 Victor Chang. All rights reserved.
//

import Foundation

class Logger {

    static func print(_ items: Any..., separator: String = " ", terminator: String = "\n") {
        #if DEBUG
        DispatchQueue.global().async(qos: .utility, execute: {
            Swift.print(items, separator: separator, terminator: terminator)
        })
        #endif
    }

}
