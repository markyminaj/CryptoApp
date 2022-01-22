//
//  CoinDataService.swift
//  CryptoApp
//
//  Created by Mark Martin on 11/17/21.
//

import Foundation
import Combine
import UIKit

class CoinDataService {
    
    @Published var allCoins: [Coin] = []
    //var cancellasbles = Set<AnyCancellable>()
    
    var coinSubscription: AnyCancellable?
    
    init() { getCoins()}
    
    public func getCoins() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h")
        else { return }
        
        coinSubscription = NetworkManager.download(url: url)
            .decode(type: [Coin].self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })
    }
}
