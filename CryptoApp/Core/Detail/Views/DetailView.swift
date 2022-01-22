//
//  DetailView.swift
//  CryptoApp
//
//  Created by Mark Martin on 1/21/22.
//

import SwiftUI

struct DetailView: View {
    
    let coin: Coin
    
    var body: some View {
        Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
