//
//  UrlImageView.swift
//  levelShoesTest
//
//  Created by Macbook Pro on 01/10/2022.
//


import Foundation
import SwiftUI
enum ImageScale {
    case fill
    case fit
}
struct UrlImageView: View {
    @ObservedObject var urlImageModel: UrlImageModel
    var imageScale: ImageScale = .fill
    var width: CGFloat = 0
    var sequire = true
    init(urlString: String?,imageScale: ImageScale,width: CGFloat = 0) {
        urlImageModel = UrlImageModel(urlString: urlString)
        self.imageScale = imageScale
        self.width = width
    }
    
    var body: some View {
        if urlImageModel.loading {

            VStack {
                ProgressView()
            }
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(Color.white)
        }
        else if let img = urlImageModel.image {
            if imageScale == .fill {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
            else {
                Image(uiImage: img)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
        
        
    }
}
struct UrlImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlImageView(urlString: "https://picsum.photos/id/2/200/200", imageScale: .fit)
    }
}


class UrlImageModel: ObservableObject {
    @Published var image: UIImage?
    @Published var loading: Bool = false
    var defualtImage: UIImage = UIImage(named: "noimage")!
    var urlString: String?
    var imageCache = ImageCache.getImageCache()
    init(urlString: String?) {
        self.urlString = urlString
        loadImage()
    }
    
    func loadImage() {
        if loadImageFromCache() {
            return
        }
        loadImageFromUrl()
    }
    func loadImageFromCache() -> Bool {
        guard let urlString = urlString else {
            return false
        }
        
        guard let cacheImage = imageCache.get(forKey: urlString) else {
            return false
        }
        
        image = cacheImage
        return true
    }
    func loadImageFromUrl() {
        loading = true
        guard let urlString = urlString else {
            loading = false
            self.image = defualtImage
            return
        }
        
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, url, error in
            self.getImageFromResponse(data: data, response: url, error: error)
            DispatchQueue.main.async {
                self.loading = false
                if self.image == nil {
                    self.image = self.defualtImage
                }
            }
        }
        task.resume()
//
    }
    
    
    func getImageFromResponse(data: Data?, response: URLResponse?, error: Error?) {
        guard error == nil else {
            print("Error: \(error!)")
            return
        }
        guard let data = data else {
            print("No data found")
            return
        }
        
        DispatchQueue.main.async {
            guard let loadedImage = UIImage(data: data) else {
                return
            }
            self.imageCache.set(forKey: self.urlString!, image: loadedImage)
            self.image = loadedImage
        }
    }
}

class ImageCache {
    var cache = NSCache<NSString, UIImage>()
    
    func get(forKey: String) -> UIImage? {
        return cache.object(forKey: NSString(string: forKey))
    }
    
    func set(forKey: String, image: UIImage) {
        cache.setObject(image, forKey: NSString(string: forKey))
    }
}

extension ImageCache {
    private static var imageCache = ImageCache()
    static func getImageCache() -> ImageCache {
        return imageCache
    }
}
