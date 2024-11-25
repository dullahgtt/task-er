struct AddTaskView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var taskManager: TaskManager
    
    @State private var title = ""
    @State private var deadline = Date().addingTimeInterval(86400) // Tomorrow
    @State private var timePerDay: Double = 30
    @State private var totalTimeNeeded: Double = 120
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Task Title", text: $title)
                
                DatePicker("Deadline", selection: $deadline, displayedComponents: .date)
                
                VStack(alignment: .leading) {
                    Text("Time per day: \(Int(timePerDay)) minutes")
                    Slider(value: $timePerDay, in: 15...240, step: 15)
                }
                
                VStack(alignment: .leading) {
                    Text("Total time needed: \(Int(totalTimeNeeded)) minutes")
                    Slider(value: $totalTimeNeeded, in: 30...480, step: 30)
                }
            }
            .navigationTitle("New Task")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") {
                        let task = Task(title: title,
                                      deadline: deadline,
                                      timePerDay: timePerDay,
                                      totalTimeNeeded: totalTimeNeeded)
                        taskManager.addTask(task)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
} 