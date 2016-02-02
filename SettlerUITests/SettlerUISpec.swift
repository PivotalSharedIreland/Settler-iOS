import Quick
import Nimble
import Settler

class SettlerUISpec: QuickSpec {
    override func spec() {
        
        beforeEach {
            self.continueAfterFailure = false
            let app = XCUIApplication()
            app.launchArguments = [HttpStubs.Enabled.rawValue, HttpStubs.PropertiesSuccess.rawValue]
            app.launch()
        }
        
        afterEach {
            XCUIApplication().terminate()
        }
        
        describe("Property List Successful Table View") {
            var tables:XCUIElementQuery!
            
            beforeEach {
                tables = XCUIApplication().tables
            }
            
            it("displays a table") {
                expect(tables.count).to(equal(1))
            }
            
            it("displays 1 cells") {
                expect(tables.childrenMatchingType(.Cell).count).toEventually(equal(1), timeout: 5)
            }
            
            it("displays the property cell") {
                let cell = tables.childrenMatchingType(.Cell).elementBoundByIndex(0)
                expect(cell.staticTexts["address"].label).notTo(beEmpty())
                expect(cell.staticTexts["contactName"].label).notTo(beNil())
                expect(cell.staticTexts["contactPhone"].label).notTo(beNil())

                expect(cell.images["thumb"]).notTo(beNil())
            }

            it("displays the property address") {
                let cell = tables.childrenMatchingType(.Cell).elementBoundByIndex(0)
                expect(cell.staticTexts["address"].label).toEventually(equal(UITestFixtures.PropertyAddress.rawValue), timeout: 5)
            }
            
            it("displays new properties when the user pulls to refresh") {
                expect(tables.childrenMatchingType(.Cell).count).toEventually(equal(1), timeout: 5)
                self.pullToRefresh(tables)
                expect(tables.childrenMatchingType(.Cell).count).toEventually(equal(2), timeout: 5)
            }
        }
    }
    
    internal func pullToRefresh(tables:XCUIElementQuery) {
        let firstCell = tables.childrenMatchingType(.Cell).elementBoundByIndex(0)
        let start = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 0))
        let finish = firstCell.coordinateWithNormalizedOffset(CGVectorMake(0, 4))
        start.pressForDuration(0, thenDragToCoordinate: finish)
    }
}