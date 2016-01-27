import Quick
import Nimble

class SettlerUISpec: QuickSpec {
    override func spec() {
        
        beforeSuite {
            self.continueAfterFailure = false
            XCUIApplication().launch()
        }
        
        describe("Property List Table View") {
            var tables:XCUIElementQuery!
            
            beforeEach {
                tables = XCUIApplication().tables
            }
            
            it("displays a table") {
                expect(tables.count).to(equal(1))
            }
            
            it("displays 2 cells") {
                expect(tables.childrenMatchingType(.Cell).count).to(equal(2))
            }
            
            it("displays the property cell") {
                let cell = tables.childrenMatchingType(.Cell).elementBoundByIndex(0)
                expect(cell.staticTexts["address"].label).notTo(beEmpty())
                expect(cell.staticTexts["contactName"].label).notTo(beEmpty())
                expect(cell.staticTexts["contactPhone"].label).notTo(beEmpty())

                expect(cell.images["thumb"]).notTo(beNil())
                
            }
            
        }
    }

}