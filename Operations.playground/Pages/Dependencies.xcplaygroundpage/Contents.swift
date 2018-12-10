import UIKit
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class ImageLoaderOperation: AsyncOperation {
    var urlString: String?
    var outputImage: UIImage?
    
    init(urlString: String?) {
        self.urlString = urlString
        super.init()
    }
    
    override func main() {
        asyncImageLoad(urlString: urlString) { [unowned self] (image) in
            self.outputImage = image
            self.state = .finished
        }
    }
}

protocol ImagePass {
    var image: UIImage? { get }
}

extension ImageLoaderOperation: ImagePass {
    var image: UIImage? { return outputImage }
}

class FilterOperation: Operation {
    var outputImage: UIImage?
    private let _inputImage: UIImage?
    
    init(_ image: UIImage?) {
        _inputImage = image
        super.init()
    }
    
    var inputImage: UIImage? {
        var image: UIImage?
        if let inputImage = _inputImage {
            image = inputImage
        } else if let dataProvider = dependencies
            .filter({ $0 is ImagePass })
            .first as? ImagePass {
            image = dataProvider.image
        }
        return image
    }
    
    override func main() {
        outputImage = filter(image: inputImage)
    }
}

let urlString = "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"
let imageLoadOperation = ImageLoaderOperation(urlString: urlString)
let filterImageOperation = FilterOperation(nil)

// Add Dependency from [imageOp] to [filterOp]
filterImageOperation.addDependency(imageLoadOperation)

let queue = OperationQueue()
queue.addOperations([filterImageOperation, imageLoadOperation], waitUntilFinished: true)

imageLoadOperation.outputImage
filterImageOperation.outputImage
sleep(3)
