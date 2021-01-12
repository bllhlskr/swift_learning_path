//
//  OnBoardingView.swift
//  fructus
//
//  Created by Halis  Kara on 11.01.2021.
//

import SwiftUI

struct OnBoardingView: View {
    //MARK : PROPERTIES
    var fruits : [Fruit] = fruitsData
    
    
    // MARK: - BODY
    var body: some View {
        TabView{
            ForEach(fruits[0...5]){item in
                FruitCardView(fruit: item)
                
                
            }//LOOP

        }//TAB
        .tabViewStyle(PageTabViewStyle())
        .padding(.vertical,20)
        
    }
}


// MARK: -PREVIEW
struct OnBoardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingView(fruits: fruitsData)
    }
}
