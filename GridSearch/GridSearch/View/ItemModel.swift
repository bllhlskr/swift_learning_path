//
//  ItemModel.swift
//  GridSearch
//
//  Created by Halis  Kara on 26.12.2020.
//

import Foundation
// our json file has one result array in the result array in has specifications
struct ItemModel: Decodable{
    let results : [Result]
}

struct Result :Decodable,Hashable{
    let collectionName, artworkUrl100, releaseDate : String
    let collectionPrice : Int
}
