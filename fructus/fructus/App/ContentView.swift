//
//  ContentView.swift
//  fructus
//
//  Created by Halis  Kara on 11.01.2021.
//

import SwiftUI

struct ContentView: View {
//MARK: - PROPERTIES
    var fruits : [Fruit] = fruitsData
    @State private var isShowingSettings: Bool = false
    
//MARK: -BODY
    var body: some View {
        NavigationView{
            List{
                ForEach(fruits.shuffled()){item in
                    NavigationLink(destination: FruitDetailView(fruits: item)){
                            FruitRowView(fruit: item)
                                .padding(.vertical,4)
                        }
                   
                }
            }
            .navigationTitle("Fruits")
            .navigationBarItems(
                trailing: Button(action:{
                    isShowingSettings = true
                    
                }){
                    Image(systemName: "gear")
                }
                .sheet(isPresented : $isShowingSettings){
                    SettingsView()
                }
            )
        }//Navigation
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// MARK: -PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(fruits: fruitsData)
            ContentView(fruits: fruitsData)
        }
    }
}
