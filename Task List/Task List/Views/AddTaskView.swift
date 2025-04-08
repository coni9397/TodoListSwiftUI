import SwiftUI

struct AddTaskView: View {
    @StateObject var viewModel = ContentViewModel()
    @State var taskTitle: String = ""
    @Environment(\.dismiss) var dismiss
    @State private var showToast = false
    var body: some View {
        VStack {
            title
            textFieldTask
            buttonAddTask
            Spacer()
        }
        .padding()
        .overlay(
            Group {
                if showToast {
                    VStack {
                        Text("Tarea agregada")
                            .padding()
                            .background(.green.opacity(0.8))
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                            .font(.custom("Avenir Next", size: 18))
                            .transition(.move(edge: .bottom)) .animation(.easeInOut, value: showToast)
                    }
                    .frame(maxWidth: .infinity, maxHeight: 50, alignment: .center)
                }
            }
        )
    }
    
    var title: some View {
        Text("Agregar tarea 📋")
            .fontWeight(.bold)
            .font(.custom("Avenir Next", size: 20))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    var textFieldTask: some View {
        TextField("Titulo de la tarea", text: $taskTitle)
            .font(.custom("Avenir Next", size: 18))
            .padding(8)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(10)
    }
    
    var buttonAddTask: some View {
        Button(action: {
            viewModel.addTask(title: taskTitle)
            showToast = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                showToast = false
            }
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
    AddTaskView()
}
