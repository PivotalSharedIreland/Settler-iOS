import Foundation

class PropertyServiceFactory {
    static func propertyService(delegate: PropertyServiceDelegate) -> PropertyService {
        if NSProcessInfo.processInfo().environment.keys.contains(kBaseUrl) {
            return PropertyService(delegate: delegate, baseURL: NSProcessInfo.processInfo().environment[kBaseUrl]!)
        } else {
            return PropertyService(delegate: delegate)
        }
    }
}