import Foundation

struct MovieItem: Identifiable, Codable {
  let id: String
  let title: String
  let image: String
  let description: String
  let duration: String
  let genre: String
  let rating: Double
}
