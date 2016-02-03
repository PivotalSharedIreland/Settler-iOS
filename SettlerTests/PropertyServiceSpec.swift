import Quick
import Nimble
import OHHTTPStubs

@testable import Settler

class PropertyServiceSpec: SettlerHttpSpec {

    override func spec() {

        describe("Property Service") {

            var delegate: MyPropertyServiceDelegate!
            var service: PropertyService!

            beforeEach {
                delegate = MyPropertyServiceDelegate()
                service = PropertyService(delegate: delegate, baseURL: "http://\(self.defaultHost)")
            }

            afterEach {
                OHHTTPStubs.removeAllStubs()
            }

            it("loads properties from server") {
                self.stubSuccessResponse([["address": "blah"]])
                service.loadProperties()

                expect(delegate.properties).toEventually(haveCount(1))
            }

            it("serializes the properties appropriately") {
                let address = "Wow! Pieces o' madness are forever fine."
                self.stubSuccessResponse([["address": address]])
                service.loadProperties()

                expect(delegate.properties).toEventually(haveCount(1))
                expect(delegate.properties[0].address).to(equal(address))
            }

            it("is ignoring invalid property objects") {
                self.stubSuccessResponse([["address": ""], ["bogus": ""]])
                service.loadProperties()

                expect(delegate.properties).toEventually(haveCount(1))
            }

            it("handles failure loading properties from server") {
                self.stubFailureResponse([])
                service.loadProperties()

                expect(delegate.error).toEventuallyNot(beNil())
                expect(delegate.error?.code).toEventually(equal(500))
            }

        }
    }
}

// MARK: - Mocks
class MyPropertyServiceDelegate: PropertyServiceDelegate {

    var properties = [Property]()
    var error: NSError?

    func loadPropertiesSuccess(properties: [Property]) {
        self.properties = properties
    }

    func loadPropertiesFailure(error: NSError) {
        self.error = error
    }

}