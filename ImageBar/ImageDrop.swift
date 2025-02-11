import SwiftUI
import UniformTypeIdentifiers
import AudioToolbox
import Cocoa

struct ImageItem: Identifiable {
    let id = UUID()
    var imageDropId: Int
    let image: NSImage
    var title: String
    var fileURL: URL?

    @discardableResult
    func save() -> URL? {
        guard let data = self.image.tiffRepresentation else { return nil }
        let bitmap = NSBitmapImageRep(data: data)
        let imageData = bitmap?.representation(using: .png, properties: [:])

        let fileManager = FileManager.default
        let tempDirectory = fileManager.temporaryDirectory
        
        let timestamp = Int(Date().timeIntervalSince1970)
        let fileURL = tempDirectory.appendingPathComponent("\(imageDropId)-\(title)-\(timestamp).png")
        
        do {
            try imageData?.write(to: fileURL)
            return fileURL
        } catch {
            return nil
        }
    }
}

struct ImageDrop: View {
    @State private var imageItem: [ImageItem] = []
    @FocusState private var isFocused: Bool
    @Binding var showtext: Bool
    var id: Int

    var body: some View {
        VStack {
            if let firstImage = imageItem.first {
                VStack {
                    Image(nsImage: firstImage.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 100)
                        .padding([.top, .leading, .trailing])
                        .border(Color.clear, width: 10)
                        .shadow(color: Color.gray.opacity(0.5), radius: 20)
                        .onDrag {
                            let provider = NSItemProvider(object: firstImage.image)
                            provider.suggestedName = firstImage.title
                            AudioServicesPlaySystemSound(1)
                            return provider
                        }

                    if showtext {
                        TextField(firstImage.title, text: $imageItem[0].title)
                            .font(.system(size: 10))
                            .padding(5)
                            .frame(width: 150)
                            .background(Color.clear)
                            .foregroundColor(.black)
                            .border(Color.clear)
                            .padding(0)
                            .textFieldStyle(PlainTextFieldStyle())
                            .overlay(
                                RoundedRectangle(cornerRadius: 0)
                                    .stroke(Color.clear, lineWidth: 0)
                            )
                            .focused($isFocused)
                            .onSubmit {
                                print("Text committed: \(imageItem[0].title)")
                                isFocused = false
                                if let fileURL = imageItem[0].fileURL {
                                    do {
                                        try FileManager.default.removeItem(at: fileURL)
                                    } catch {
                                        print("Error removing file: \(error)")
                                    }
                                }

                                let updatedImageItem = ImageItem(imageDropId: firstImage.imageDropId, image: firstImage.image, title: imageItem[0].title)
                                let newFileURL = updatedImageItem.save()
                                self.imageItem[0].fileURL = newFileURL
                            }
                            .onTapGesture {
                                if !isFocused {
                                    isFocused = true
                                }
                            }
                    }
                    
                    Button(action: {
                        AudioServicesPlaySystemSound(3)
                        guard let firstItem = imageItem.first else { return }
                            
                        if let fileURL = firstItem.fileURL {
                            do {
                                try FileManager.default.removeItem(at: fileURL)
                            } catch {
                                print("Error removing file: \(error)")
                            }
                        }
                        imageItem.removeAll()
                    }) {
                        Image(systemName: "x.circle")
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .black)
                            .padding(3)
                    }
                }
            } else {
                ZStack {
                    Image(systemName: "square.dashed")
                        .resizable()
                        .scaledToFit()
                        .padding(.all)
                        .frame(width: 150, height: 100)
                    
                    Image(systemName: "photo.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .padding(.all)
                        .frame(width: 60, height: 50)
                }
                .padding()
                .scaledToFit()
                .onDrop(of: [UTType.image], delegate: ImageDropDelegate(imageItem: $imageItem, id: id))
            }
        }
        .onAppear {
            loadSavedImages()
        }
    }

    private func loadSavedImages() {
        let fileManager = FileManager.default
        let tempDirectory = fileManager.temporaryDirectory
        self.imageItem.removeAll()

        do {
            let items = try fileManager.contentsOfDirectory(at: tempDirectory, includingPropertiesForKeys: nil)
            for item in items {
                if item.pathExtension == "png", let image = NSImage(contentsOf: item) {
                    let components = item.lastPathComponent.components(separatedBy: "-")
                    if components.count >= 3, let imageDropId = Int(components[0]), imageDropId == id {
                        let title = components.dropFirst().dropLast().joined(separator: "-")
                        let imageItem = ImageItem(imageDropId: id, image: image, title: title, fileURL: item)
                        self.imageItem.append(imageItem)
                    }
                }
            }
        } catch {
            print("Error loading images: \(error)")
        }
    }

    struct ImageDropDelegate: DropDelegate {
        @Binding var imageItem: [ImageItem]
        var id: Int
        
        func performDrop(info: DropInfo) -> Bool {
            guard info.hasItemsConforming(to: [UTType.image]) else {
                return false
            }
            AudioServicesPlaySystemSound(1)
            
            let items = info.itemProviders(for: [UTType.image])
            
            for item in items {
                item.loadItem(forTypeIdentifier: UTType.image.identifier, options: nil) { (data, error) in
                    
                    if let url = data as? URL {
                        if let image = NSImage(contentsOf: url) {
                            let imageName = url.lastPathComponent
                            let savedURL = ImageItem(imageDropId: id, image: image, title: imageName).save()
                            let imageItem = ImageItem(imageDropId: id, image: image, title: imageName, fileURL: savedURL)
                            
                            DispatchQueue.main.async {
                                self.imageItem.insert(imageItem, at: 0)
                            }
                        }
                    } else if let image = data as? NSImage {
                        let imageName = item.suggestedName ?? "Untitled"
                        let savedURL = ImageItem(imageDropId: id, image: image, title: imageName).save()
                        let imageItem = ImageItem(imageDropId: id, image: image, title: imageName, fileURL: savedURL)
                        
                        DispatchQueue.main.async {
                            self.imageItem.insert(imageItem, at: 0)
                        }
                    }
                }
            }
            return true
        }
    }
}
