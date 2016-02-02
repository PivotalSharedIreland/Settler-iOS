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
        
        describe("Property Info Successful View") {
            var tables:XCUIElementQuery!
            var app:XCUIApplication!

            beforeEach {
                app = XCUIApplication()
                tables = app.tables
                let cell = tables.childrenMatchingType(.Cell).elementBoundByIndex(0)
                cell.tap()
                expect(tables.count).toEventually(equal(0))
            }

            it("displays property information") {
                expect(app.staticTexts["address"].label).to(equal(UITestFixtures.PropertyAddress.rawValue))
            }
            
            it("displays a back button") {
                expect(app.buttons["Back"].exists).to(beTrue())
            }
            
            it("display an edit button") {
                expect(app.buttons["Edit"].exists).to(beTrue())
            }

            describe("Property Update View") {
                beforeEach {
                    app.buttons["Edit"].tap()
                    expect(app.staticTexts["address"].exists).toEventually(beFalse(), timeout: 5)
                }
                
                it("displays the top buttons") {
                    expect(app.buttons["Cancel"].exists).to(beTrue())
                    expect(app.buttons["Save"].exists).to(beTrue())
                }
                
                it("goes back when we cancel") {
                    app.buttons["Cancel"].tap()
                    expect(app.staticTexts["address"].exists).toEventually(beTrue(), timeout: 5)
                }
                
                it("displays the address text field") {
                    expect(app.textFields["address"].exists).to(beTrue())
                    expect(app.textFields["address"].value as? String).to(equal(UITestFixtures.PropertyAddress.rawValue))
                }
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