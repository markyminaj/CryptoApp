//
//  HomeView.swift
//  CryptoApp
//
//  Created by Mark Martin on 11/16/21.
//

import SwiftUI

struct HomeView: View {
    
    
    @EnvironmentObject private var viewModel : HomeViewModel
    @State private var showPortfolio = false //animate right
    @State private var showPortfolioView = false //new sheet
    @State private var selectedCoin: Coin? = nil
    @State private var showDetailView: Bool = false
    
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
                .sheet(isPresented: $showPortfolioView) {
                    PortfolioView()
                        .environmentObject(viewModel)
                }
                
            VStack {
                homeHeader
                HomeStatsView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $viewModel.searchText)
                columnTitles
               
                
                if !showPortfolio {
                    allCoinList
                        .transition(.move(edge: .leading))
                }
                if showPortfolio {
                    portfolioCoinsList
                        .transition(.move(edge: .trailing)) 
                }
                    
                
                Spacer(minLength: 0)
            }
        }
        .background (
            NavigationLink(
                destination: DetailLoadingView(coin: $selectedCoin),
                isActive: $showDetailView,
                label: { EmptyView() })
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(dev.homeViewModel)
    }
}

extension HomeView {
    private var homeHeader: some View {
        HStack {
            CircleButtonView(iconName: showPortfolio ? "plus" : "info" )
                .animation(.none)
                .onTapGesture {
                    if showPortfolio {
                        showPortfolioView.toggle()
                    }
                }
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.headline)
                .fontWeight(.heavy)
                .foregroundColor(Color.theme.accent)
                .animation(.none)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
            
        }
        .padding(.horizontal)
    }
    
    private var allCoinList : some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                        .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
                        .onTapGesture {
                            segue(coin: coin)
                        }
                }
        }
        .listStyle((PlainListStyle()))
    }
    
    private func segue(coin: Coin) {
        selectedCoin = coin
        showDetailView.toggle()
    }
    
    private var portfolioCoinsList : some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 0, trailing: 10))
                    .onTapGesture {
                        segue(coin: coin)
                    }
                
            }
        }
        .listStyle((PlainListStyle()))
    }
    
    private var columnTitles: some View {
        HStack {
            HStack {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ?  1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
                
            }
            
            Spacer()
            if showPortfolio {
                HStack {
                    Text("Holdings")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ?  1.0 : 0.0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                }
                .onTapGesture {
                    withAnimation(.default) {
                        viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                    }
                    
                }
                
            }
            HStack {
                Text("Price")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .price || viewModel.sortOption == .priceReversed) ?  1.0 : 0.0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .price ? 0 : 180))
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .price ? .priceReversed : .price
                }
                
            }
            
            Button {
                withAnimation(.linear(duration: 2.0)) {
                    viewModel.reloadData()
                }
            } label: {
                Image(systemName: "goforward")
            }
            .rotationEffect(Angle(degrees: viewModel.isloading ? 360: 0), anchor: .center)

        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
