//
//  ContentView.swift
//  Slot Machine
//
//  Created by Halis  Kara on 29.01.2021.
//

import SwiftUI


struct ContentView: View {
    // MARK: - PROPERTIES
    @State private var highScore : Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins : Int = 100
    @State private var betAmount: Int = 10
    let symbols = ["gfx-bell","gfx-cherry","gfx-coin","gfx-grape","gfx-seven","gfx-strawberry"]
    let haptics = UINotificationFeedbackGenerator()
    @State private var reels: Array =  [0,1,2]
    @State private var showingInfoView : Bool = false
    @State private var isActivateBet10:Bool = true
    @State private var isActivateBet20 : Bool = false
    @State private var showingModel : Bool = false
    @State private var animatingSymbol : Bool = false
    @State private var animatingModal : Bool = false
    //MARK: - Functions
    // Spin the reels
    func spinReels(){
     
        reels = reels.map({_ in Int.random(in: 0...symbols.count-1)})
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    func checkWinning(){
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2]{
            //Player wins
            playerWins()
            //new High Score
            if coins > highScore {
                newHighScore()
            }else{
                playSound(sound: "win", type: "mp3")
            }
        }else{
            //Player loses
            playerLoses()
        }
    }
    func playerWins(){
        coins += betAmount * 10
    }
    
    func newHighScore(){
        highScore = coins
        UserDefaults.standard.set(highScore,forKey: "HighScore")
        playSound(sound: "high-score", type: "mp3")
    }
    func playerLoses(){
        coins -= betAmount
    }
   
    func activateBet20(){
        betAmount = 20
        if coins < 11{
            //TODO
        }
        haptics.notificationOccurred(.success)
        isActivateBet20 = true
        isActivateBet10 = false
        playSound(sound: "casino-chips", type: "mp3")
    }
    func activateBet10(){
        betAmount = 10
        isActivateBet10 = true
        isActivateBet20 = false
        haptics.notificationOccurred(.success)
        playSound(sound: "casino-chips", type: "mp3")
    }
    func isGameOver(){
        if coins <= 0 {
            // Show modal window
            showingModel = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    func resetGame(){
        UserDefaults.standard.set(0,forKey: "HighScore")
        highScore = 0
        coins = 100
        activateBet10()
        playSound(sound: "chimeUp", type: "mp3")
    }
   
    // Game is over
// MARK: - BODY
    var body: some View {
        ZStack{
        // MARK: - BACKGROUND
        LinearGradient(gradient: Gradient(colors: [Color("ColorPink"),Color("ColorPurple")]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
        //MARK: -INTERFACE
        VStack(alignment: .center, spacing: 5){
            //MARK: - HEADER
            LogoView()
            Spacer()
            
            //MARK: - SCORE
            HStack {
                HStack{
                    Text("Your\nCoins".uppercased())
                        .scoreLabelStyle()
                        .multilineTextAlignment(.trailing)
                    Text("\(coins)")
                        .scoreNumberStyle()
                        .modifier(ScoreNumberModifier())
                }
                .modifier(ScoreContainerModifer())
                
                Spacer()
                
                HStack{
                    Text("\(highScore)")
                        .scoreNumberStyle()
                        .modifier(ScoreNumberModifier())
                    Text("High\nScore".uppercased())
                        .scoreLabelStyle()
                        .multilineTextAlignment(.trailing)
                    
                }
                .modifier(ScoreContainerModifer())
            }
            //MARK: - SLOT MACHINE
            VStack(alignment: .center, spacing: 0) {
                //MARK: - REEL#1
                ZStack{
                ReelView()
                    Image(symbols[reels[0]])
                        .resizable()
                        .modifier(ImageModifier())
                        .opacity(animatingSymbol ? 1 : 0)
                        .offset(y: animatingSymbol ? 0 : -50)
                        .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                        .onAppear(perform: {
                            self.animatingSymbol.toggle()
                            playSound(sound: "riseup", type: "mp3")
                        })
                }
                HStack(alignment: .center, spacing: 0) {
                    //MARK: - REEL#2
                    ZStack{
                    ReelView()
                        Image(symbols[reels[1]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                            })
                    }
                    Spacer()
                    //MARK: - REEL#3
                    ZStack{
                    ReelView()
                        Image(symbols[reels[2]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                            })
                    }
                }.frame(maxWidth:500)
                
                
               
                
                //MARK: - SPIN BUTTON
                Button(action: {
                    withAnimation{
                        self.animatingSymbol = false
                    }
                    
                    self.spinReels()
                    
                    withAnimation{
                        self.animatingSymbol = true
                    }
                    
                    self.checkWinning()
                    
                    self.isGameOver()
                }){
                    Image("gfx-spin").resizable()
                        .renderingMode(.original)
                        .modifier(ImageModifier())
                }
            }//Slot Machine
            .layoutPriority(2)
            //MARK: - FOOTER
            Spacer()
            HStack{
                //MARK: -BET20
                HStack(alignment: .center,spacing: 10) {
                    Button(action: {
                        self.activateBet20()
                    }){
                        Text("20")
                            .fontWeight(.heavy)
                            .foregroundColor(isActivateBet20 ? Color("ColorYellow") : Color.white)
                            .modifier(BetNumberModifier())
                    }
                    .modifier(BetCapsuleModifier())
                    Image("gfx-casino-chips")
                        .resizable()
                        .offset(x: isActivateBet20 ? 0 : 20)
                        .opacity(isActivateBet20 ? 1: 0)
                        .modifier(CasinoChipsModifier())
                }
                Spacer()
                //MARK: -BET10
                HStack(alignment: .center,spacing: 10) {
                    Image("gfx-casino-chips")
                        .resizable()
                        .offset(x: isActivateBet10 ? 0 : -20)
                        .opacity(isActivateBet10 ? 1 : 0)
                        .modifier(CasinoChipsModifier())
                    Button(action: {
                        self.activateBet10()
                    }){
                        Text("10")
                            .fontWeight(.heavy)
                            .foregroundColor(isActivateBet10 ? Color("ColorYellow") : Color.white)
                            .modifier(BetNumberModifier())
                    }
                    .modifier(BetCapsuleModifier())
                   
                }
            }
        }
        //MARK: -BUTTONS
        .overlay(
            Button(action:{
                self.resetGame()
            }){
                Image(systemName: "arrow.2.circlepath.circle")
            }
            .modifier(ButtonModifier()),
            alignment: .topLeading
            
        )
        .overlay(
            Button(action:{
                self.showingInfoView = true
            }){
                Image(systemName: "info.circle")
            }
            .modifier(ButtonModifier()),
            alignment: .topTrailing
            
        )
        .padding()
        .frame(maxWidth:720)
        //.blur(radius: $showingModel.wrappedValue ? 5: 0 , opaque:false)
        
        //MARK: -POPUP
            if $showingModel.wrappedValue{
                ZStack{
                    Color("ColorTransparentBlack").edgesIgnoringSafeArea(.all)
                    
                    //MODAL
                    VStack(spacing: 0){
                        //Title
                        Text("GAME OVER")
                            .font(.system(.title,design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(Color.white)
                        Spacer()
                        
                        //Message
                        VStack(alignment: .center,spacing: 16){
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("Bad Luck! You lost all of the coins.\nLet's play again")
                                .font(.system(.body,design : .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.black)
                                .layoutPriority(1)
                            
                            Button(action : {
                                self.showingModel = false
                                self.animatingModal = false
                                self.activateBet10()
                                self.coins = 100
                                
                            }){
                                Text("new Game".uppercased())
                                    .font(.system(.body,design:.rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal,12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                    )
                            }
                        }
                        Spacer()
                    }.frame(minWidth: 200, idealWidth: 200, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6,x:0,y:8 )
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                    .onAppear(perform: {
                        self.animatingModal = true
                    })
                }
            }
    }//Z-stack
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}
//MARK: - PREVIEW
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        
            ContentView()
            
        
    }
}
