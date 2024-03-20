import Foundation

class MockURLSessionDataTask: URLSessionDataTask {
    override func resume() {
    }
}

class MockURLSession: URLSession {
    var mockData: Data?
    var mockError: Error?
    
    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = mockData
        let error = mockError
        completionHandler(data, nil, error)
        return MockURLSessionDataTask()
    }
}
