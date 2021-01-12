//
//  fructusApp.swift
//  fructus
//
//  Created by Halis  Kara on 11.01.2021.
//

import SwiftUI

@main
struct fructusApp: App {
    @AppStorage("isOnboarding") var isOnboarding : Bool = true
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnBoardingView()

            }else{
                ContentView()
            }
        }
    }
}
