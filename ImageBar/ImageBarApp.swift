
import SwiftUI


@main
struct ImageBarApp: App {

    
    
    @AppStorage("firsttimelaunch") private var firstLaunch: Bool = true
    @AppStorage("view") public var viewopen: Bool = true
    @AppStorage("textshow") public var showtext: Bool = false
    @AppStorage("darkmodeison") public var darkmode: Bool = false
    @AppStorage("modemanual") public var modemanual: Bool = false
    @AppStorage("screenheight") private var height: Double = 0.0
    @AppStorage("numberofimagesinapp") private var imagenumber: Double = 3.0
    @AppStorage("info-window") private var info: Bool = false

    init() {
        
       
            viewopen = true
            if let screen = NSScreen.main {
                let screenHeight = screen.frame.height
                height = screenHeight
            
            }
        
        
        
        
        }
  

        
    var body: some Scene {
        
        
        
        WindowGroup {
            Group{
                
                if firstLaunch == true {
                    
                    LaunchView(showtext: $showtext, info: $info).onAppear(){
                        launchwindow()}
                    
                    
                    
                }else{
                    if viewopen == true  {
                        
                        ContentView(viewopen: $viewopen, showtext:$showtext, imagenumber: $imagenumber, info: $info)
                            .onAppear(){
                                mainwindow()
                                
                                
                            }
                    }else{
                        ClosedContentView(viewopen: $viewopen)
                            .onAppear(){
                                closedmainwindow()
                                    
                            }

                    }
                    
                }
                
            } .preferredColorScheme(modemanual ? (darkmode ? .dark : .light) : nil)
            
            
            
        }.windowStyle(HiddenTitleBarWindowStyle())
          
       
       
        Settings{
            
            Settingsview(showtext: $showtext,modemanual: $modemanual,darkmode: $darkmode, imagenumber: $imagenumber, height: $height, info: $info)
            
            
        }

        
    }
}
func mainwindow(){
    if let window = NSApplication.shared.windows.first{
        if let screen = NSScreen.main {
            let screenWidth = screen.frame.width
            let screenHeight = screen.frame.height
            
            window.setFrame(NSRect(x: 0, y: 0, width: (screenWidth)*0.125, height: screenHeight), display: true)
            
            
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.styleMask.remove(.resizable)
            window.isMovable=false
            window.level = .floating
            
        }
    }}
func closedmainwindow(){
    if let window = NSApplication.shared.windows.first{
        if let screen = NSScreen.main {
            let screenWidth = screen.frame.width
            let screenHeight = screen.frame.height
            
            window.setFrame(NSRect(x: 0, y: screenHeight, width: (screenWidth)*0.025, height: (screenWidth)*0.025), display: true)
            
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.styleMask.remove(.resizable)
            window.isMovable=false
            window.level = .floating
            
        }
    }}
func launchwindow(){
    if let window = NSApplication.shared.windows.first{
        if let screen = NSScreen.main {
            let screenWidth = screen.frame.width
            let screenHeight = screen.frame.height
            
            window.setFrame(NSRect(x: screenWidth/2-250, y: screenHeight-350, width: 500, height: 700), display: true)
            
            
            window.standardWindowButton(.miniaturizeButton)?.isHidden = true
            window.standardWindowButton(.closeButton)?.isHidden = true
            window.standardWindowButton(.zoomButton)?.isHidden = true
            window.styleMask.remove(.resizable)
            window.isMovable=false
            window.level = .floating
            
        }
    }}


