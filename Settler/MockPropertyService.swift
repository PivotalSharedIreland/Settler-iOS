import Foundation

class MockPropertyService: PropertyService {
    
    private var invocations: Int = 0
    
    override func loadProperties() {
        self.performSelector(Selector(actionSelector()), withObject: nil, afterDelay: 0)
    }

    func returnSuccess() {
        delegate.loadPropertiesSuccess(getProperties())
        invocations++
    }

    func returnFailure() {
        delegate.loadPropertiesFailure(NSError(domain: "Settler", code: 402, userInfo: nil))
    }

    private func getProperties() -> [Property] {
        let property = Property(address: UITestFixtures.PropertyAddress.rawValue)
        return Array.init(count: invocations + 1, repeatedValue: property)
    }

    private func actionSelector() -> String {
        var selector = "returnSuccess"
        if NSProcessInfo.processInfo().arguments.contains(HttpStubs.PropertiesFailure.rawValue) {
            selector = "returnFailure"
        }
        return selector
    }
}
