import Quick
import Nimble
import SwiftyJSON
@testable import Settler

class PropertySerializerSpec: QuickSpec {
    override func spec() {
        describe("Property Serializer") {
            it("serializes a property with all attributes") {
                let address = "22 King's Lynn"
                let property = PropertySerializer.fromJson(JSON(["address": address]))!
                expect(property.address).to(equal(address))
            }

            it("won't create a property without an address") {
                expect(PropertySerializer.fromJson(JSON([]))).to(beNil())
            }
        }
    }
}
