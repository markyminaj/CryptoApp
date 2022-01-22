//
//  String+Ext.swift
//  CryptoApp
//
//  Created by Mark Martin on 1/21/22.
//

import Foundation


extension String {
    
    
    var removingHTMLOccurances: String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
}
