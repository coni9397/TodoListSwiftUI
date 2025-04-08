import Foundation
import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var task: [TaskModels] = []
    private var persistenceService: TaskPersistence
    
    init(persistenceService: TaskPersistence = UserDefaultsPersistence()) {
        self.persistenceService = persistenceService
        self.task = persistenceService.loadTasks()
    }
    
    func addTask(title: String) {
        let newTask = TaskModels(title: title, isCompleted: false)
        task.append(newTask)
        persistenceService.saveTasks(task)
    }
    
    func toggleTaskCompletion(id: UUID) {
        if let index = task.firstIndex(where: { $0.id == id }) {
            task[index].isCompleted.toggle()
            persistenceService.saveTasks(task)
        }
    }
    
    func removeTask(id: UUID) {
        persistenceService.deleteTask(id: id)
        task.removeAll { $0.id == id }
    }
}
