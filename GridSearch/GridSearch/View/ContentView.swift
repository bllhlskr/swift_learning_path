//
//  ContentView.swift
//  GridSearch
//
//  Created by Halis  Kara on 26.12.2020.
//

import SwiftUI
import KingfisherSwiftUI

struct ContentView: View {
    
    @State var isShowingDetailsScreen = false
    @State private var searchText: String = ""
    @State var isSearching = false
    @ObservedObject var vm = APICall()
    
    var body: some View {
        NavigationView{
            ScrollView{
                HStack{
                    //TextField of search if search bigger than 2 letter it makes api call
                    TextField("Search", text: $searchText)
                        .onChange(of: searchText){newValue in
                            if(searchText.count>2){
                                vm.fetchData(term: searchText, entity: "musicVideo")

                            }
                        }
                        .padding(.leading,24)
                }
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(6)
                .padding(.horizontal)
                .onTapGesture(perform: {
                    isSearching = true
                })
                //overlays the Textfield to put cancel button and search image
                .overlay(
                    HStack{
                        
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.blue)
                            .padding(.leading,25)
                        Spacer()
                        // if user searching cancel button activates when you clicked X it deletes users search
                        if isSearching{
                            Button(action: {searchText = ""}, label:{
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.red)
                                    .padding(.trailing,25)

                            })
                        }
                        
                }).padding(.horizontal,32)
                //Grid View
                LazyVGrid(columns:[
                    GridItem(.flexible(minimum: 100, maximum: 200),spacing:12,alignment:.top),
                    GridItem(.flexible(minimum: 100, maximum: 200),spacing:12,alignment:.top)
                    ],spacing: 16,content:{
                        //ForEach Results in api
                        ForEach(vm.results,id:\.self){result in
                            VStack(alignment:.leading,spacing:4){
                               //goes for details Screen when you clicked the items image
                                NavigationLink(destination: InfoScreen(item: result)){
                                    //Donwloads and shows image from api
                                    KFImage(URL(string: result.artworkUrl100))
                                        .resizable()
                                        .scaledToFit()
                                        .cornerRadius(5.0)
                                }
                                    
                                //Items name and Price in horizontal view
                                HStack{
                                    Text(result.collectionName)
                                    .font(.system(size: 10,weight:.semibold))
                                    Text("\(result.collectionPrice)")
                                        .font(.system(size: 10,weight:.semibold))
                                }
                                
                            Text(result.releaseDate)
                                .font(.system(size: 9,weight:.regular))
                            

                            }.padding(.horizontal)
                            onTapGesture(count: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/, perform: {
                                isShowingDetailsScreen.toggle()
                            })
                            .sheet(isPresented: $isShowingDetailsScreen, content: {
                                //DetailsScreen()
                            })

                            
                    }

                    }).padding(.horizontal,12)
            }.navigationTitle("HepsiBurada")
        }
       
    }
   
      
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11")
    }
}

