import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var navigateToAddTaskView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                title
                taskList
                Spacer()
                buttonAddTask
            }
            .padding()
            
            NavigationLink(destination: AddTaskView(viewModel: viewModel).environmentObject(viewModel), isActive: $navigateToAddTaskView) {
            }
        }
    }
    
    var title: some View {
        Text("Lista de tareas 📋")
            .fontWeight(.bold)
            .font(.custom("Avenir Next", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    var taskList: some View {
        List {
            ForEach(viewModel.task) { task in
                HStack {
                    Text(task.title)
                    Spacer()
                    Button(action: {
                        self.viewModel.toggleTaskCompletion(id: task.id)
                    }) {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                    }
                }
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.removeTask(id: task.id)
                    } label: {
                        Label("Eliminar", systemImage: "trash")
                    }
                }
            }
        }
    }
    var buttonAddTask: some View {
        Button(action: { navigateToAddTaskView.toggle()
        }, label: {
            Text("Agregar tarea"
                .uppercased())
            .font(.subheadline)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
            .frame(maxWidth: .infinity, alignment: .center)
        })
    }
}

#Preview {
    ContentView()
}
