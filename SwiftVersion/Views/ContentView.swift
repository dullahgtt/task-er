struct ContentView: View {
    @StateObject private var taskManager = TaskManager()
    @State private var showingAddTask = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(taskManager.tasks) { task in
                    TaskRow(task: task)
                }
                .onDelete(perform: taskManager.deleteTask)
            }
            .navigationTitle("TaSkEr")
            .toolbar {
                Button(action: { showingAddTask = true }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                }
            }
        }
        .sheet(isPresented: $showingAddTask) {
            AddTaskView(taskManager: taskManager)
        }
    }
} 