import Foundation

class PropertyServiceFactory {
    static func propertyService(delegate: PropertyServiceDelegate) -> PropertyService {
        var result: PropertyService
#if DEBUG
        if NSProcessInfo.processInfo().arguments.contains(HttpStubs.Enabled.rawValue) {
            result = MockPropertyService(delegate: delegate)
        } else {
            result = PropertyService(delegate: delegate)
        }
#else
        result = PropertyService(delegate: delegate)
#endif
        return result
    }
}