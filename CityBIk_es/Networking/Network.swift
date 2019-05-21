
import Foundation

enum NetworkError: Error {
    case genericError
    case invalidURL
    case invalidParameters
    
    var localizedDescription: String {
        get {
            switch self {
            case .genericError:
                return "generic error"
            case .invalidURL:
                return "invalid URL"
            case .invalidParameters:
                return "invalid parameters"
            }
        }
    }
}

enum Result<Value> {
    case success(Value)
    case error(Error)
}

protocol Session {
    func data(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Token?
}

extension URLSession: Session  {
    
    @discardableResult
    func data(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Token? {
        
        let task = dataTask(with: url) { (data, response, error) in
            completion(data, response ,error)
        }
        
        task.resume()
        return Token(task: task)
    }
    
}

class URLSessionMock: Session {
    var data: Data?
    var error: Error?
    
    @discardableResult
    func data(_ url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) -> Token? {
        completion(data, nil, error)
        return nil
    }
}

fileprivate protocol ResponseDecodable  {
    func request<T: Decodable>(_ url: URL?, then handler: @escaping (Result<T>, URLResponse?) -> Void ) -> Token?
}

class Token {
    
    private weak var task: URLSessionDataTask?
    
    init(task: URLSessionDataTask) {
        self.task = task
    }
    
    func cancel() {
        task?.cancel()
    }
    
}

class NetworkManager: ResponseDecodable {
    
    static let shared = NetworkManager()
    
    private let session: Session
    
    init(_ session: Session = URLSession.shared) {
        self.session = session
    }
    
    @discardableResult
    func request<T: Decodable>(_ url: URL?, then handler: @escaping (Result<T>, URLResponse?) -> Void ) -> Token? {
        
        guard let url = url else {
            handler(.error(NetworkError.invalidURL), nil)
            return nil
        }
    
        
        return session.data(url, completion: { data, response, error in
            
            if let error = error {
                handler(.error(error), response)
            } else if let data = data {
                do {
                    let json: T = try data.decode()
                    handler(.success(json), response)
                } catch let decodeError {
                    handler(.error(decodeError), response)
                }
            } else {
                handler(.error(NetworkError.genericError), response)
            }
            
        })
        
    }
    
}
