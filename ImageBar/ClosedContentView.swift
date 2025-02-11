
import SwiftUI
import AudioToolbox
struct ClosedContentView: View {
    @Binding var viewopen: Bool
    var body: some View {
        GeometryReader { geometry in
            @State var screenwidth = geometry.size.width
            @State var screenheight = geometry.size.height
            
            
            
            
           
                ZStack{
                    Button(action: { AudioServicesPlaySystemSound(15)
                        viewopen=true
                        }) {
                        ZStack{
                            
                            Rectangle()
                                .foregroundStyle(Color.background)
                                .background(Color.clear)
                                .frame(width: 40, height: 40)
                            Image(systemName: "plus")
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(PlainButtonStyle()) 
                    .background(Color.clear)
                    .frame(width: 40, height: 40)
                    .contentShape(Rectangle())
                }
                .position(x: screenwidth*0.5, y: -5)
                .background(Color.clear)
                
            }.background(Color.background)
        
    }
}


