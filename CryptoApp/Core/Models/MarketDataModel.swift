//
//  MarketDataModel.swift
//  CryptoApp
//
//  Created by Mark Martin on 1/7/22.
//

import Foundation

// URL:https://api.coingecko.com/api/v3/global
//JSON DATA
/*
 JSON RESPONSE
{"data":{"active_cryptocurrencies":12298,"upcoming_icos":0,"ongoing_icos":50,"ended_icos":3375,"markets":708,"total_market_cap":{"btc":50240029.928348884,"eth":653198524.7380317,"ltc":15840848202.378345,"bch":5408130062.25768,"bnb":4613841971.749181,"eos":730628062591.5739,"xrp":2718688845931.402,"xlm":8018799027820.079,"link":78665831867.48767,"dot":82962447038.13828,"yfi":59495802.14127052,"usd":2109886932558.0059,"aed":7749614703285.56,"ars":217935040245670.56,"aud":2938950123611.212,"bdt":181323628126974.88,"bhd":795513878938.6055,"bmd":2109886932558.0059,"brl":11890900774510.389,"cad":2667508949963.7627,"chf":1938754003458.2275,"clp":1747640445107123.2,"cny":13456225889775.201,"czk":45389786591427.14,"dkk":13814094361841.033,"eur":1856951577196.0193,"gbp":1551958981547.031,"hkd":16452202037399.596,"huf":666101854043224.6,"idr":3.0210943515564936e+16,"ils":6572719772304.725,"inr":156618594913327.06,"jpy":243764830889913.34,"krw":2526916634212757.5,"kwd":638601587764.2659,"lkr":428067845207957.1,"mmk":3751593988885205.5,"mxn":42978398926093.53,"myr":8880514099136.633,"ngn":871826379402294.0,"nok":18639796105683.695,"nzd":3112722521263.6265,"php":108308098170820.6,"pkr":373449987062767.3,"pln":8441524694287.836,"rub":159190969061501.5,"sar":7919880468856.054,"sek":19094476739649.94,"sgd":2860479208815.5166,"thb":70917696807641.92,"try":29274681189242.32,"twd":58264531862363.1,"uah":58016615928014.01,"vef":211262978557.0332,"vnd":4.801047715035743e+16,"zar":32884159709681.273,"xdr":1505699710550.6956,"xag":94317874667.62329,"xau":1174510758.7470675,"bits":50240029928348.88,"sats":5.024002992834888e+15},"total_volume":{"btc":3360494.7892870824,"eth":43691658.661086015,"ltc":1059575161.836086,"bch":361743273.6390298,"bnb":308614304.70423126,"eos":48870826724.178894,"xrp":181849806090.3851,"xlm":536367760683.2848,"link":5261862273.224048,"dot":5549257661.187299,"yfi":3979602.189038059,"usd":141127783023.97607,"aed":518362347047.06433,"ars":14577411044402.924,"aud":196582816340.98312,"bdt":12128518003758.15,"bhd":53210960439.14311,"bmd":141127783023.97607,"brl":795367959566.5228,"cad":178426444799.38278,"chf":129680908542.90146,"clp":116897553956589.7,"cny":900070661792.0126,"czk":3036067883416.4956,"dkk":924008050709.6246,"eur":124209243267.27876,"gbp":103808657720.03104,"hkd":1100467879852.568,"huf":44554746739584.32,"idr":2020773443174556.5,"ils":439641269676.2919,"inr":10476028236096.178,"jpy":16305134475144.256,"krw":169022394977580.0,"kwd":42715287215.64997,"lkr":28632940014850.14,"mmk":250939580831252.97,"mxn":2874773081326.1763,"myr":594006838747.9143,"ngn":58315411223337.17,"nok":1246793399125.316,"nzd":208206241678.62112,"php":7244597586022.936,"pkr":24979617595243.777,"pln":564643368828.5981,"rub":10648091229158.99,"sar":529751218009.3159,"sek":1277206436366.9824,"sgd":191333991834.75555,"thb":4743598897735.65,"try":1958147989457.667,"twd":3897244010462.6587,"uah":3880661213701.7974,"vef":14131124914.190727,"vnd":3211362702710575.5,"zar":2199581638627.0195,"xdr":100714431077.23029,"xag":6308808470.242023,"xau":78561602.9759569,"bits":3360494789287.0825,"sats":336049478928708.25},"market_cap_percentage":{"btc":37.66536968028812,"eth":18.235349632199558,"usdt":3.7278608199962195,"bnb":3.644187142288631,"sol":2.1184688228765123,"usdc":1.8939093470175183,"ada":1.8845706394922552,"xrp":1.7500052675833317,"dot":1.292607275771454,"luna":1.1906878513942636},"market_cap_change_percentage_24h_usd":1.8330309178716069,"updated_at":1641627834}
 
 }
 */
  
  // MARK: - Global Data
  struct GlobalData: Codable {
      let data: MarketDataModel
  }

  // MARK: - Market Data
  struct MarketDataModel: Codable {
      let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
      let marketCapChangePercentage24HUsd: Double
      

      enum CodingKeys: String, CodingKey {
          case totalMarketCap = "total_market_cap"
          case totalVolume = "total_volume"
          case marketCapPercentage = "market_cap_percentage"
          case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
      }
      
      var marketCap: String {
          
          if let item = totalMarketCap.first(where: {$0.key == "usd" }) {
              return "$" + item.value.formattedWithAbbreviations()
          }
          return ""
      }
      
      var volume: String {
          if let item = totalVolume.first(where: {$0.key == "usd"}) {
              return "$" + item.value.formattedWithAbbreviations()
          }
          return ""
      }
      
      var btcDominance: String {
          if let item = marketCapPercentage.first(where: {$0.key == "btc"}) {
              return item.value.asPercentString()
          }
          return ""
      }
  }
