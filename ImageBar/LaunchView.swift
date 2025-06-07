import SwiftUI

struct LaunchView: View {
    @AppStorage("firsttimelaunch") public var firstLaunch: Bool = true
    @Binding var showtext: Bool
    @Binding var info: Bool
    var body: some View {
        VStack {
            Text("ImageBar")
                .font(.largeTitle)
                .padding()
            Text("Welcome to the app! Tap the button below to continue.")
                .padding()
            TutorialView()
            Spacer()
            Toggle(isOn: $showtext){
                Text("View and Edit Image Filename")
                    .foregroundStyle(Color.text)
            }.toggleStyle(.switch)
            Spacer()
           
            Toggle(isOn: $info){
                Text("Button for showing information")
                    .foregroundStyle(Color.text)
            }.toggleStyle(.switch)
            Spacer()
            Button(action: {
                
                firstLaunch = false
            }) {
                Text("Start the App")
                    .padding(.all)
                
            }
            Spacer()
            
            
        }
    }
}


