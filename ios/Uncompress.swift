@objc(Uncompress)
class Uncompress: NSObject {
    
    // MARK: - Private Properties
    
    private let extractUseCase = UseCaseFactory.extractUseCase()
    private let isProctedUseCase = UseCaseFactory.isProtectedUseCase()
    
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
            try extractUseCase.run(
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
            let isProtected = try isProctedUseCase.run(filePath)
            resolve(isProtected)
        } catch {
            reject("IS_PROTECTED_THROW", error.localizedDescription, error)
        }
    }
    
}
