//
//  Array+Identifiable.swift
//  Memorize-Stanford
//
//  Created by Halis  Kara on 20.12.2020.
//

import Foundation

extension Array where Element:Identifiable{
    func firstIndex(matching: Element)->Int?{
        for index in 0..<self.count{
            if self[index].id == matching.id{
                return index
            }
        }
        
        return nil
    }
}
