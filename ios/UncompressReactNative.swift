@objc(UncompressReactNative)
class UncompressReactNative: NSObject {
    
    // MARK: - Private Properties
    
    private let uncompress = ComponentFactory.uncompressUseCase()
    
    // MARK: - Public Methods

    @objc
    func extract(
        _ filePath: String,
        to destination: String,
        overwrite: Bool = true,
        password: String? = nil,
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) {
        do {
            try uncompress.extract(
                filePath,
                to: destination,
                overwrite: overwrite,
                password: password
            )
            resolve(NSNull())
        } catch {
            reject("EXTRACT_THROW", error.localizedDescription, error)
        }
    }
    
    @objc
    func isProtected(
        _ filePath: String,
        resolver resolve: RCTPromiseResolveBlock,
        rejecter reject: RCTPromiseRejectBlock
    ) {
        do {
            let isProtected = try uncompress.isProtected(filePath)
            resolve(isProtected)
        } catch {
            reject("IS_PROTECTED_THROW", error.localizedDescription, error)
        }
    }
    
}
