//
//  FruitDetailView.swift
//  fructus
//
//  Created by Halis  Kara on 11.01.2021.
//

import SwiftUI

struct FruitDetailView: View {
    // MARLK : - Properties
    var fruits : Fruit
    
    // MARK : -BODY
    var body: some View {
        NavigationView{
            ScrollView(.vertical,showsIndicators:false){
                VStack(alignment:.center,spacing:20){
                    FruitHeaderView(fruit: fruits)
                    VStack(alignment: .leading, spacing: 20) {
                        Text(fruits.title)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .foregroundColor(fruits.gradientColor[1])
                        
                        //HEADLINE
                        Text(fruits.headline)
                            .font(.headline)
                            .multilineTextAlignment(.leading)
                        //nuttitiens
                        FruitNutrientsView(fruit: fruits)
                        //Subheading
                        Text("Learn more about \(fruits.title)".uppercased())
                            .fontWeight(.bold)
                            .foregroundColor(fruits.gradientColor[1])
                        //description
                        Text(fruits.description).multilineTextAlignment(.leading)
                        //LINK
                        SourceLinkView()
                            .padding(.top,10)
                            .padding(.bottom,40)
                        
                        
                    }//Vstack
                    .padding(.horizontal,20)
                    .frame(maxWidth:640,alignment:.center)
                }//Vstack
                .navigationBarTitle(fruits.title,displayMode: .inline)
                .navigationBarHidden(true)
            }//scroll
            .edgesIgnoringSafeArea(.top)
        }//navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}



//MARK : - PREVIEW
struct FruitDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FruitDetailView(fruits: fruitsData[0])
    }
}
