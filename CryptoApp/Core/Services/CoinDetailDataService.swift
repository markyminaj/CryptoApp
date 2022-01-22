//
//  CoinDetailDataService.swift
//  CryptoApp
//
//  Created by Mark Martin on 1/21/22.
//

import Foundation
import Combine
import UIKit

class CoinDetailDataService {
    
    @Published var coinDetails: CoinDetailModel? = nil
    let coin: Coin
    //var cancellasbles = Set<AnyCancellable>()
    
    var coinDetailSubscription: AnyCancellable?
    
    init(coin: Coin) {
        self.coin = coin
        getCoinDetails()
        
    }
    
    public func getCoinDetails() {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
        else { return }
        
        coinDetailSubscription = NetworkManager.download(url: url)
            .decode(type: CoinDetailModel.self, decoder: JSONDecoder())
            .sink(receiveCompletion: NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
                self?.coinDetails = returnedCoinDetails
                self?.coinDetailSubscription?.cancel()
            })
    }
}
