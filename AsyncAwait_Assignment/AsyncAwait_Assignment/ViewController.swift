import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Task {
            let greeting = await loadGreeting()
            print(greeting)
        }
        Task {
            await runFetchUsersTask()
        }
    }

    private func runGreetingTask() async {
        let greeting = await loadGreeting()
        print(greeting)
    }

    private func runFetchUsersTask() async {
        do {
            let users = try await LiveUserService().fetchUsers()
            for user in users {
                print("Name:\(user.name), Email:\(user.email), Phone:\(user.phone)")
            }
        } catch NetworkError.http(let status, _) {
            print("Server returned an error status: \(status)")
        } catch NetworkError.decoding(let error) {
            print("Failed to decode response: \(error)")
        } catch NetworkError.transport(let error) {
            print("Network error: \(error.localizedDescription)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
