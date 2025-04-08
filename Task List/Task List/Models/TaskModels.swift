import Foundation

struct TaskModels: Identifiable, Codable {
    var id = UUID()
    var title: String
    var isCompleted: Bool
}
