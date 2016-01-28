import Quick
import Nimble
import OHHTTPStubs
import Alamofire

public class SettlerHttpSpec: QuickSpec {
    public func stubSuccessResponse(response: AnyObject) {
        stub(isHost("settler.cfapps.io")) {
            _ in
            return OHHTTPStubsResponse(JSONObject: response, statusCode: 200, headers: nil)
        }
    }

    public func stubFailureResponse(response: AnyObject) {
        stub(isHost("settler.cfapps.io")) {
            _ in
            return OHHTTPStubsResponse(error: Error.errorWithCode(500, failureReason: "Network is down"))
        }
    }
}
