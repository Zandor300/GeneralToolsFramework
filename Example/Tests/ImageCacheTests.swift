#if os(iOS) || os(tvOS)
import XCTest
import GeneralToolsFramework

class ImageCacheTests: XCTestCase {

    func testImageDataIsCachedAndCanBeRemoved() {
        let image = Image(
            url: "https://example.invalid/image.png",
            cachingKey: "GeneralToolsFrameworkTests-\(UUID().uuidString)",
            imageData: Data([1, 2, 3]) as NSData
        )
        defer { image.removeCachedImage() }

        // PINCache may finish storing the data asynchronously.
        let cached = expectation(for: NSPredicate { _, _ in image.downloaded }, evaluatedWith: nil)
        wait(for: [cached], timeout: 5)

        image.removeCachedImage()

        XCTAssertFalse(image.downloaded)
    }
}
#endif
