@objc(UncompressManager)
class UncompressManager: NSObject {

    @objc
    func multiply(
        a: Float,
        b: Float,
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) -> Void {
        resolve(a * b)
    }
    
}
