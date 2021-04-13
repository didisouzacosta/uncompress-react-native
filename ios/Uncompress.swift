@objc(Uncompress)
class Uncompress: NSObject {
    
    // MARK: - Private Properties
    
    private let decompressUseCase = UseCaseFactory.decompressUseCase()
    
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
            try decompressUseCase.extract(
                filePath,
                to: destination,
                overwrite: overwrite,
                password: password
            )
            resolve(NSNull())
        } catch {
            reject("0", error.localizedDescription, error)
        }
    }
    
}
