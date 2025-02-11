

import SwiftUI
import AVKit
struct TutorialView: View {
    @State var player = AVPlayer(url: Bundle.main.url(forResource: "Tutorial", withExtension: "mov")!)
    var body: some View {
      
           
        VideoPlayer(player: player)
                    .frame(width: 350, height: 275, alignment: .center)
                    .onAppear(){
                        player.play()
                    }
        
        
           
        }
    }


