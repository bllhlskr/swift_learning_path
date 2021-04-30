//
//  APICall.swift
//  GridSearch
//
//  Created by Halis  Kara on 26.12.2020.
//

import Foundation

class APICall: ObservableObject{
    @Published var results = [Result]()
    
  //this func makes api calls according to search and selected entity
    func fetchData(term: String,entity:String?){
       
        guard let url = URL(string:" https://itunes.apple.com/search?term=\(term)&limit=20&entity=\(entity)") else{return}
        
    // makes request with given url
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
                guard let data = data,
                      let rss = try? JSONDecoder().decode(ItemModel.self,from:data) else {return}
                //decodes the json
           // guard let rss = try? JSONDecoder().decode(ItemModel.self,from:data)else{return}
                
                
                self.results = rss.results
                print(self.results[0].collectionName)
//             catch {
//            print("failed to decode\(err)")
//            }
        }.resume()
    }
}
