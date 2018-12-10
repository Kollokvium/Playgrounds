import UIKit

public func filter(image: UIImage?) -> UIImage? {
    guard let image = image else { return .none }
    sleep(1)
    let mask = topAndBottomGradient(size: image.size)
    return image.applyBlur(radius: 6, maskImage: mask)
}

func filterAsync(image: UIImage?, callback: @escaping (UIImage?) ->()) {
    OperationQueue().addOperation {
        let result = filter(image: image)
        callback(result)
    }
}

public class Filter: ImageTakeOperation {
    
    override public func main() {
        if isCancelled { return }
        guard let inputImage = inputImage else { return }
        
        if isCancelled { return }
        let mask = topAndBottomGradient(size: inputImage.size)
        
        if isCancelled { return }
        outputImage = inputImage.applyBlurWithRadius(6, maskImage: mask)
    }
}
