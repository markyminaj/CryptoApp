//
//  HomeStatsView.swift
//  CryptoApp
//
//  Created by Mark Martin on 1/7/22.
//

import SwiftUI

struct HomeStatsView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack {
            ForEach(vm.stats) { stat in
                StatView(stat: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
                
            }
        }
        .frame(width: UIScreen.main.bounds.width,
               alignment: showPortfolio ? .trailing : .leading
        )
        
    }
}

struct HomeStatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatsView(showPortfolio: .constant(false))
            .environmentObject(dev.homeViewModel)
    }
}
