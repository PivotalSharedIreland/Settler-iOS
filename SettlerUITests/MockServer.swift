import Foundation
import GCDWebServers

@objc class MockServer: NSObject {
    let baseURL = NSURL(string: "http://localhost:\(serverPort)")!
    
    private static let serverPort = 8080
    
    private let webServer = GCDWebServer()
    
    func start() throws {
        try webServer.startWithOptions([
            GCDWebServerOption_Port: MockServer.serverPort,
            GCDWebServerOption_AutomaticallySuspendInBackground: false ])
    }
    
    func stop() {
        webServer.stop()
    }
    
    internal func respondWith(responseBodyAsString: String) {
        let responseBody = responseBodyAsString.dataUsingEncoding(NSUTF8StringEncoding)
        webServer.removeAllHandlers();

        webServer.addHandlerForMethod("GET", path: "/properties", requestClass: GCDWebServerDataRequest.self) { request -> GCDWebServerResponse! in
            return GCDWebServerDataResponse(data: responseBody, contentType: "application/json")
        }

    }
}