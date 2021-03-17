@objc(UncompressManager)
class UncompressManager: NSObject {
    
    // MARK: - Private Properties
    
    private let decompressUseCase = UseCaseFactory.decompressUseCase()
    
    // MARK: - Public Methods

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
