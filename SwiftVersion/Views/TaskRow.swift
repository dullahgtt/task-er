struct TaskRow: View {
    let task: Task
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(task.title)
                .font(.headline)
            
            HStack {
                Image(systemName: "clock")
                Text("\(Int(task.timePerDay)) min/day")
                
                Spacer()
                
                Image(systemName: "calendar")
                Text(task.deadline.formatted(date: .abbreviated, time: .omitted))
            }
            .foregroundColor(.secondary)
            .font(.subheadline)
            
            ProgressView(value: calculateProgress())
                .tint(.blue)
        }
        .padding(.vertical, 8)
    }
    
    private func calculateProgress() -> Double {
        // Simple progress calculation
        let now = Date()
        let total = task.deadline.timeIntervalSince(now)
        let remaining = max(0, total)
        return 1 - (remaining / total)
    }
} 