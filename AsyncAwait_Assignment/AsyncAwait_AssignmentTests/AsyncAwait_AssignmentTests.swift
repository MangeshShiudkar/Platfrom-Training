import XCTest
@testable import AsyncAwait_Assignment

struct FailingUserService: UserFetching {
    func fetchUsers() async throws -> [User] {
        throw NetworkError.http(status: 500, data: Data())
    }
}

struct SuccessfulUserService: UserFetching {
    func fetchUsers() async throws -> [User] {
        return [User(id: 1,name: "Leanne Graham",username: "Bret",email: "test@example.com",phone: "123456789",website: "example.com")]
    }
}

class UserServiceTests: XCTestCase {
    func testFetchUsersSucceeds() async throws {
        let service: UserFetching = SuccessfulUserService()
        let users = try await service.fetchUsers()
        XCTAssertFalse(users.isEmpty)
        XCTAssertEqual(users.count, 1)
        XCTAssertEqual(users.first?.name, "Leanne Graham")
        XCTAssertEqual(users.first?.username, "Bret")
        XCTAssertEqual(users.first?.email, "test@example.com")
    }

    func testFetchUsersThrowsOnFailure() async {
        let service: UserFetching = FailingUserService()
        do {
            _ = try await service.fetchUsers()
            XCTFail("Expected fetchUsers to throw")
        } catch NetworkError.http(let status, _) {
            XCTAssertEqual(status, 500)
        } catch {
            XCTFail("Expected NetworkError.http, got \(error)")
        }
    }
}
