import Foundation

protocol TaskPersistence {
    func saveTasks(_ tasks: [TaskModels])
    func loadTasks() -> [TaskModels]
    func deleteTask(id: UUID)
}

struct UserDefaultsPersistence: TaskPersistence {
    private static let tasksKey = "tasks"
    
    func saveTasks(_ tasks: [TaskModels]) {
        if let encoded = try? JSONEncoder().encode(tasks) {
            UserDefaults.standard.set(encoded, forKey: UserDefaultsPersistence.tasksKey)
        }
    }
    
    func loadTasks() -> [TaskModels] {
        if let savedData = UserDefaults.standard.data(forKey: UserDefaultsPersistence.tasksKey),
           let decodedTasks = try? JSONDecoder().decode([TaskModels].self, from: savedData) {
            return decodedTasks
        }
        return []
    }
    
    func deleteTask(id: UUID) {
        var savedTasks = loadTasks()
        if let index = savedTasks.firstIndex(where: { $0.id == id }) {
            savedTasks.remove(at: index)
            saveTasks(savedTasks)
        }
    }
}
