//
//  StatModel.swift
//  CryptoApp
//
//  Created by Mark Martin on 12/19/21.
//

import Foundation

struct StatModel: Identifiable {
    let id = UUID().uuidString
    let title: String
    let value: String
    let percentageChange: Double?
    
    init(title: String, value: String, percentageChange: Double? = nil) {
        self.title = title
        self.value = value
        self.percentageChange = percentageChange
    }
    
}


