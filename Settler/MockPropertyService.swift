import Foundation

class MockPropertyService: PropertyService {
    override func loadProperties() {
        self.performSelector(Selector(actionSelector()), withObject: nil, afterDelay: 0)
    }

    func returnSuccess() {
        delegate.loadPropertiesSuccess(getProperties())
    }

    func returnFailure() {
        delegate.loadPropertiesFailure(NSError(domain: "Settler", code: 402, userInfo: nil))
    }

    private func getProperties() -> [Property] {
        return [Property(address: UITestFixtures.PropertyAddress.rawValue)]
    }

    private func actionSelector() -> String {
        var selector = "returnSuccess"
        if NSProcessInfo.processInfo().arguments.contains(HttpStubs.PropertiesFailure.rawValue) {
            selector = "returnFailure"
        }
        return selector
    }
}
