import SwiftyJSON

class PropertySerializer {
    internal static func fromJson(json: JSON) -> Property? {
        guard let address = json["address"].string else {
            return nil
        }

        return Property(address: address)
    }
}
