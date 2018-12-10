import UIKit
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

class AsyncOperation: Operation {
    enum State: String {
        case ready, executing, finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue.capitalized
        }
    }
    
    var state = State.ready {
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
}

extension AsyncOperation {
    override var isReady: Bool {
        return super.isReady && state == .ready
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override func start() {
        if isCancelled {
            state = .finished
            return
        }
        
        main()
        state = .executing
    }
    
    override func cancel() {
        state = .finished
    }
}

public func asyncAdd(lhs: Int, rhs: Int, callback: @escaping (Int) -> ()) {
    let addQueue = OperationQueue()
    addQueue.addOperation { sleep(1); callback(lhs + rhs) }
}

class SumOperation: AsyncOperation {
    let lhs: Int
    let rhs: Int
    var result: Int?
    
    init(lhs: Int, rhs: Int) {
        self.lhs = lhs
        self.rhs = rhs
        super.init()
    }
    
    override func main() {
        asyncAdd(lhs: lhs, rhs: rhs) { (result) in
            self.result = result
            self.state = .finished
        }
    }
}

let addingTwoIntQueue = OperationQueue()
let input = [(1,2), (1,3), (4,2), (5,2), (5,5), (10,3)]

input.forEach { lhs, rhs in
    let operation = SumOperation(lhs: lhs, rhs: rhs)
    operation.completionBlock = {
        guard let result = operation.result else { return }
        print("\(lhs) + \(rhs) = \(result)")
    }
    
    addingTwoIntQueue.addOperation(operation)
}

// ----------- ----------- ----------- Load View ----------- ----------- -----------

//------------------------------------------------------------------------------
var view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
var eiffelImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
eiffelImage.backgroundColor = .yellow
eiffelImage.contentMode = .scaleAspectFit
view.addSubview(eiffelImage)
//------------------------------------------------------------------------------

let imageURL = URL(string:"http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")
let imageString = "http://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg"

class ImageLoaderOperation: AsyncOperation {
    var url: URL?
    var outImage: UIImage?
    
    init(url: URL) {
        self.url = url
        super.init()
    }

    override func main() {
        if let imageString = url {
            asyncImageLoad(urlString: imageString.absoluteString) { [unowned self] (image) in
                self.outImage = image
                self.state = .finished
            }
        }
    }
}

let operationLoad = ImageLoaderOperation(url: imageURL ?? URL(string:"https://google.com")!)
operationLoad.completionBlock = {
    OperationQueue.main.addOperation {
        eiffelImage.image = operationLoad.outImage
    }
}

let loadQueue = OperationQueue()
loadQueue.addOperation(operationLoad)
loadQueue.waitUntilAllOperationsAreFinished()
sleep(3)
operationLoad.outImage

//PlaygroundPage.current.finishExecution()
