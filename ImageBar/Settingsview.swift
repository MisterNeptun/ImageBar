
import SwiftUI


struct Settingsview: View {
    @Binding var showtext: Bool
    @Binding var modemanual: Bool
    @Binding var darkmode: Bool
    @Binding var imagenumber: Double
    @Binding var height: Double
    var body: some View {
        TabView {
            Tab("General", systemImage: "gear"){
                GeneralView(showtext: $showtext,modemanual: $modemanual,darkmode: $darkmode, imagenumber: $imagenumber, height: $height)
            }
            Tab("Tutorial", systemImage: "play.square"){
                TutorialView()
            }
            Tab("Credits", systemImage: "c.circle"){
                CreditsView()
            }
        }.frame(maxWidth: 500, minHeight: 350)
            
        
    }
}

