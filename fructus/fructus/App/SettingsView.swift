//
//  SettingsView.swift
//  fructus
//
//  Created by Halis  Kara on 11.01.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage("isOnboarding") var isOnboarding : Bool = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical,showsIndicators:false){
                VStack(spacing:20) {
                    //MARK: -SECTION1
                    GroupBox(
                        label:LabelView(labelText: "Fructus", labelImage: "info.circle")
                            
                    ){
                        Divider().padding(.vertical,4)
                        HStack(alignment:.center,spacing:10) {
                            Image("logo").resizable().scaledToFit()
                                .frame(width: 80, height: 80)
                                .cornerRadius(9)
                            
                            Text("Most fruits are naturally low in fat,and calories. None habe cholestorla. Fruits are sources of many essential nutrients including potassium dietary fiber,vitamins,and much more")
                                .font(.footnote)
                        }

                    }
                    //MARK: -SECTION2
                    GroupBox(label:LabelView(labelText:"Customization", labelImage:"paintbrush")){
                        Divider().padding(.vertical,4)
                        Text("If you wish, you can restart the application by toggle the switch in this box. That way it starts the onboarding process and you will see the welcome screen again")
                            .padding(.vertical,8)
                            .frame(minHeight:60)
                            .layoutPriority(1)
                            .font(.footnote)
                            .multilineTextAlignment(.leading)
                        
                        
                        Toggle(isOn: $isOnboarding){
                            if isOnboarding {
                                Text("Restarted".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.green)
                            } else {
                                Text("Restart".uppercased())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.secondary)
                            }
                        }
                        .padding()
                        .background(Color(UIColor.tertiarySystemBackground)
                                        .clipShape(RoundedRectangle(cornerRadius: 8,style: .continuous))
                        )
                    }
                    
                    //MARK: -SECTION3
                    GroupBox(label: LabelView(labelText: "Application", labelImage: "apps.iphone")){
                        
                       SettingsRowView(name: "Developer",content: "Halis Bilal Kara")
                        SettingsRowView(name: "Designer",content: "Halis Bilal Kara")
                        SettingsRowView(name: "Compatibility",content: "iOS14")
                        SettingsRowView(name: "Website",linklabel: "Personal website",linkDestination: "halisbilalkara.com")
                        SettingsRowView(name: "Twitter",linklabel: "@HalisbKara",linkDestination: "twitter.com/halisbkara")
                        SettingsRowView(name: "SwiftUI",content: "2.0")
                        SettingsRowView(name: "Version",content: "1.1.0")
                        
                    }
                }//VSTACK
                .navigationBarTitle(Text("Settings"),displayMode:.large)
                .navigationBarItems(
                    trailing: Button(action:{
                        presentationMode.wrappedValue.dismiss()
                    }){
                        Image(systemName: "xmark")
                    }
                )
                .padding()
            }//scroll
        }//Navigation

    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
