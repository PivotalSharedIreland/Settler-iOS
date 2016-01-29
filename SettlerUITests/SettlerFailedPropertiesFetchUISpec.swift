import Quick
import Nimble

class SettlerFailedPropertiesFetchUISpec: QuickSpec {
    override func spec() {
        beforeEach {
            self.continueAfterFailure = false
            let app = XCUIApplication()
            app.launchArguments.removeAll()
            app.launchArguments = [HttpStubs.Enabled.rawValue, HttpStubs.PropertiesFailure.rawValue]
            app.launch()
        }

        afterEach {
            XCUIApplication().terminate()
        }
        
        describe("Property List Failed Table View") {
            it("displays an error message when data cannot be fetched") {
                expect(XCUIApplication().alerts["Error"].staticTexts["Unable to load properties from the remote service"]).toEventuallyNot(beNil())
                expect(XCUIApplication().alerts.count).toEventually(equal(1))
            }
        }
    }

}
