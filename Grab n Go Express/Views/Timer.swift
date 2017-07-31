import Foundation

class Timeout: NSObject
{
    fileprivate var timer: Timer?
    fileprivate var callback: ((Void) -> Void)?
    
    init(_ delaySeconds: Double, _ callback: @escaping (Void) -> Void)
    {
        super.init()
        self.callback = callback
        self.timer = Timer.scheduledTimer(timeInterval: TimeInterval(delaySeconds),
                                                            target: self, selector: #selector(Timeout.invoke), userInfo: nil, repeats: false)
    }
    
    func invoke()
    {
        self.callback?()
        // Discard callback and timer.
        self.callback = nil
        self.timer = nil
    }
    
    func cancel()
    {
        self.timer?.invalidate()
        self.timer = nil
    }
}
