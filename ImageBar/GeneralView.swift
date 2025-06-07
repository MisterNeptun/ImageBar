

import SwiftUI
import Cocoa

struct GeneralView: View {
    @Binding var showtext: Bool
    @Binding var modemanual: Bool
    @Binding var darkmode: Bool
    @Binding var imagenumber: Double
    @Binding var height: Double
    @Binding var info: Bool
    var body: some View {
        VStack{
            Toggle(isOn: $showtext){
                Text("Show image name & rename image")
                    .foregroundColor(.text)
            }.toggleStyle(.switch)
            Toggle(isOn: $info){
                Text("Button for showing information")
                    .foregroundStyle(Color.text)
            }.toggleStyle(.switch)
            
            
            
            Toggle(isOn: $modemanual){
                Text("Set dark/ligthmode manually")
                    .foregroundColor(.text)
            }.toggleStyle(.switch)
            if modemanual {
                HStack{
                    Text("Light")
                        .foregroundColor(.text)
                    Toggle(isOn: $darkmode){
                    }.toggleStyle(DarkmodeToggleStyl())
                    
                    Text("Dark")
                        .foregroundColor(.text)
                    
                    
                }
                
            }
            
            
            
            VStack{
                HStack{Spacer()
            Slider(value: $imagenumber, in: 1...Double((roundscreen(number: height))), step: 1).padding(.all)
            Spacer()}
                Text("Number of Imagespaces: \(Int(imagenumber)) ").padding(.all)
                
            }.scaledToFit()
        }
    }
}

func roundscreen(number:Double) -> Double{
    
    let value = round(number/250) - 1
    
    
    return value

}
struct DarkmodeToggleStyl: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
           
            Rectangle()
                .foregroundColor(configuration.isOn ? .gray : Color(NSColor.controlAccentColor))
                .frame(width: 40, height: 25, alignment: .center)
                .overlay(
                    Circle()
                        .foregroundColor(.white)
                        .padding(.all, 3)
                        .overlay(
                            Image(systemName: configuration.isOn ? "moon" : "sun.max")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.black))
                                .frame(width: 8, height: 8, alignment: .center)
                                .foregroundColor(configuration.isOn ? .gray : Color(NSColor.controlAccentColor))
                        )
                        .offset(x: configuration.isOn ? 8 : -8, y: 0)
                    
                    
                ).cornerRadius(20)
                .onTapGesture { configuration.isOn.toggle()
                   }
        }       }
}
