

import SwiftUI
import AudioToolbox


struct ContentView: View {
    @Binding var viewopen: Bool
    @Environment(\.openSettings) private var openSettings
    @Binding var showtext: Bool
    @Binding var imagenumber:Double
    @Binding var info: Bool
  
   
    var body: some View {
       
        GeometryReader { geometry in
            @State var screenwidth = geometry.size.width
            @State var screenheight = geometry.size.height
           
            
                
            ZStack {
                Spacer()
               
                            LazyVStack {
                                Spacer()
                                let imagenumberint = Int(imagenumber)
                                ForEach(0..<imagenumberint, id: \.self) { i in
                                    ImageDrop(showtext: $showtext,id: i, info: $info)
                                        .padding(.all)
                                        .border(Color.clear, width: 10)
                                        
                                    Spacer()
                                }
                            
                        
                    }.scaledToFit()
                    .padding()
                    .frame(width: screenwidth, height: screenheight)
                    .background(Color.background)
                    VStack {
                        Button(action: { AudioServicesPlaySystemSound(15)
                            viewopen=false
                            }) {
                            ZStack{
                                
                                Rectangle()
                                    .foregroundStyle(Color.clear)
                                    .background(Color.background)
                                    .frame(width: 40, height: 40)
                                Image(systemName: "minus")
                                    .foregroundColor(Color.button)
                            }
                        }
                        .buttonStyle(PlainButtonStyle()) //
                        .background(Color.clear)
                        .frame(width: 40, height: 40) //
                        .contentShape(Rectangle()) // Makes
                    }
                    .position(x: screenwidth * 0.8, y: 0)
                    .background(Color.clear)
                    
                    
                    
                    
                    
                    
                    VStack {
                        Button(action: {openSettings() }) {
                            ZStack{
                                
                                Rectangle()
                                    .foregroundStyle(Color.clear)
                                    .background(Color.background)
                                    .frame(width: 40, height: 40)
                                Image(systemName: "gear")
                                    .foregroundColor(Color.button)
                            }
                        }
                        .buttonStyle(PlainButtonStyle()) 
                        .background(Color.clear)
                        .frame(width: 40, height: 40)
                        .contentShape(Rectangle())
                    }
                    .position(x: screenwidth*0.2 , y: 0)
                    .background(Color.clear)
                    
                    
                }
           
                }
                
                
        }
    
    }



