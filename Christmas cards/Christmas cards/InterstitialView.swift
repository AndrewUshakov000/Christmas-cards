//
//  InterstitialView.swift
//  Christmas cards
//
//  Created by Andrew Ushakov on 12/21/21.
//

import GoogleMobileAds
import SwiftUI
import UIKit

final class Interstitial: NSObject, GADFullScreenContentDelegate {
  var interstitial:GADInterstitialAd?

  override init() {
    super.init()
    self.loadInterstitial()
  }

    func loadInterstitial(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-2181499186463628/5254473362",
                               request: request,
                               completionHandler: { [self] ad, error in
                                if let error = error {
                                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                    return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                               })
    }

    func showAd(){
        if self.interstitial != nil {
            let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitial?.present(fromRootViewController: root!)
        }
        else{
            print("Not Ready")
        }
    }

    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        self.loadInterstitial()
    }

}
