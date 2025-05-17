import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com/"
    
    private init() {}
    
    func getFollowers(userName: String, page: UInt, completion: @escaping ([Follower]?, ErrorMessage?) -> Void) {
        let url = baseURL + "users/\(userName)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: url) else {
            completion(nil, .invalidURL)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(nil, .somthingWentWrong)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }
        
        task.resume()
    }
}

struct Follower: Decodable {
    var loginId: String
    var followerURL: String
  
  enum CodingKeys: String, CodingKey {
    case login = "login"
    case avatarUrl = "avatarUrl"
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.loginId = try container.decode(String.self, forKey: .login)
    self.followerURL = try container.decode(String.self, forKey: .avatarUrl)
  }
}

enum ErrorMessage: String {
    case invalidURL = "Invalid URL"
    case somthingWentWrong = "Somthing went wrong"
    case invalidResponse = "Invalid Response"
    case invalidData = "invalid Data"
    case decodingError = "Error while decoding data"
}
