import Foundation
import Combine

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
                
                let followers = try decoder.decode([Follower].self, from: data)
                completion(followers, nil)
            } catch {
                completion(nil, .decodingError)
            }
        }
        
        task.resume()
    }
  
  func getFollowersWithCombine(userName: String, page: UInt, cancellableCollection: inout Set<AnyCancellable>, completion: @escaping ([Follower]?, ErrorMessage?) -> Void) throws {
      let url = baseURL + "users/\(userName)/followers?per_page=100&page=\(page)"
      guard let url = URL(string: url) else {
        completion(nil, .invalidURL)
        return
      }
      
      URLSession.shared.dataTaskPublisher(for: url)
        .subscribe(on: DispatchQueue.global(qos: .background))
        .receive(on: DispatchQueue.main)
        .tryMap { output -> Data in
          guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode == 200 else {
              throw URLError(.badServerResponse)
          }
          
          return output.data
        }
        .decode(type: [Follower].self, decoder: JSONDecoder())
        .sink { completion in
          print("Completion \(completion)")
        } receiveValue: { followes in
          completion(followes, nil)
        }
        .store(in: &cancellableCollection)
    }
}

struct Follower: Decodable, Hashable {
    var loginId: String
    var followerURL: String
  
  enum CodingKeys: String, CodingKey {
    case login = "login"
    case avatarUrl = "avatar_url"
  }
  
  init(from decoder: any Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.loginId = try container.decode(String.self, forKey: .login)
    self.followerURL = try container.decode(String.self, forKey: .avatarUrl)
  }
  
  func hash(into hasher: inout Hasher) {
    hasher.combine(loginId)
    hasher.combine(followerURL)
  }
}

enum ErrorMessage: String {
    case invalidURL = "Invalid URL"
    case somthingWentWrong = "Somthing went wrong"
    case invalidResponse = "Invalid Response"
    case invalidData = "invalid Data"
    case decodingError = "Error while decoding data"
}
