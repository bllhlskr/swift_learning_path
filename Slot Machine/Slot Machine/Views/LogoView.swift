//
//  LogoView.swift
//  Slot Machine
//
//  Created by Halis  Kara on 29.01.2021.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine").resizable().scaledToFit()
            .frame(minWidth: 256, idealWidth: 300, maxWidth:320, minHeight: 122, idealHeight: 130, maxHeight: 140, alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
