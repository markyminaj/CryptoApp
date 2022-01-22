//
//  UIApp.swift
//  CryptoApp
//
//  Created by Mark Martin on 12/7/21.
//

import Foundation
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
