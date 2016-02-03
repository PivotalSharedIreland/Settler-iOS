import Alamofire
import SwiftyJSON

protocol PropertyServiceDelegate {
    func loadPropertiesSuccess(properties: [Property])

    func loadPropertiesFailure(error: NSError)
}

class PropertyService: NSObject {

    var delegate: PropertyServiceDelegate
    var baseURL: String!

    init(delegate: PropertyServiceDelegate, baseURL: String = "https://settler.cfapps.io/") {
        self.delegate = delegate
        self.baseURL = baseURL
    }


    func loadProperties() {
        let urlToHit = "\(baseURL)/properties"
        Alamofire.request(.GET, urlToHit).responseJSON { response in
            if response.result.isSuccess {
                self.delegate.loadPropertiesSuccess(self.propertiesFromSuccessResponse(response))
            } else {
                self.delegate.loadPropertiesFailure(response.result.error!)
            }
        }
    }

    private func propertiesFromSuccessResponse(response: Response<AnyObject, NSError>) -> [Property] {
        var properties = [Property]()
        let json = JSON(data: response.data!)
        for (_, property) in json {
            if let property = PropertySerializer.fromJson(property) {
                properties.append(property)
            }
        }
        return properties
    }


}