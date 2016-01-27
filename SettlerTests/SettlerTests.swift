import Quick
import Nimble

class SettlerSpec: QuickSpec {
    override func spec() {
        describe("Basic test") {
            it("should be true") {
                expect(true).to(beTruthy())
            }
            
            it("should be false") {
                expect(true).to(beFalse())
            }
        }
    }
}