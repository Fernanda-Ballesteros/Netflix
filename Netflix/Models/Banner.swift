import SwiftUI

struct Banner: Identifiable, Codable {
  let id: String
  let image: String
  let title: String
  let description: String
  let duration: String?
  let genre: String?
  let rating: Double?
  let release: String?
}
