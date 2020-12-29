//
//  Array+Only.swift
//  Memorize
//
//  Created by Natalia MACARI on 09.12.20.
//

import Foundation

extension Array {
    var only : Element? {
        count == 1 ? first : nil
    }
    
}
