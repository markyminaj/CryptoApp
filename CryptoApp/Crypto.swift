//
//  CryptoAppApp.swift
//  CryptoApp
//
//  Created by Mark Martin on 11/12/21.
//

import SwiftUI

@main
struct Crypto: App {
    
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                HomeView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
           
        }
    }
}
