import Foundation

//Task 1
func loadGreeting() async -> String {
    try? await Task.sleep(for: .seconds(1))
    return "Hello!"
}

