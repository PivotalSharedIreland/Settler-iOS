import Quick
import Nimble
import OHHTTPStubs

public class SettlerHttpSpec: QuickSpec {
    internal let defaultHost = "localhost"
    
    public func stubSuccessResponse(response: AnyObject) {
        stub(isHost(defaultHost)) { _ in
            return OHHTTPStubsResponse(JSONObject: response, statusCode: 200, headers: nil)
        }
    }

    public func stubFailureResponse(response: AnyObject) {
        stub(isHost(defaultHost)) { _ in
            return OHHTTPStubsResponse(error: NSError(domain: "", code: 500, userInfo: nil))
        }
    }
}
