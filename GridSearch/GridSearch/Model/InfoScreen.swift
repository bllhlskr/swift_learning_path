//
//  denemeScreen.swift
//  GridSearch
//
//  Created by Halis  Kara on 27.12.2020.
//

import SwiftUI
import KingfisherSwiftUI

struct InfoScreen: View {
    
    var body: some View {
        VStack{
            KFImage(URL(string: item.artworkUrl100))
                .resizable()
                .scaledToFill()
            Spacer()
            HStack{

                Text(item.collectionName)
                    .font(.system(size: 10,weight:.semibold))
                Text("\(item.collectionPrice)")
                    .font(.system(size: 10,weight:.semibold))

            }
            Text(item.releaseDate)
                .font(.system(size: 10,weight:.semibold))
        }
    }
}

//struct denemeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        InfoScreen()
//    }
//}
