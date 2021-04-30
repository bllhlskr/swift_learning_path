//
//  DetailsScreen.swift
//  GridSearch
//
//  Created by Halis  Kara on 26.12.2020.
//

import SwiftUI

struct TitlePage: View{
    var title : String
    var body : some View{
        Text(title)
    }
    
}
struct ContainerView : View {
    var controllers : [UIHostingController<TitlePage>]
    
    init(_ titles : [String]){
        self.controllers = titles.map{UIHostingController(rootView: TitlePage(title: $0))}
    }
    var body : some View{
        DetailsScreen(controllers: self.controllers)
    }
}
struct DetailsScreen: UIViewControllerRepresentable {
    var controllers : [UIViewController]
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        return pageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        <#code#>
    }
    
    typealias UIViewControllerType = UIPageViewController
    
  
    
  
    
   
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContainerView(["Subscribe","weekly","monthly"])
        }
    }
    
    
 
   

}

