//
//  ViewModel.swift
//  AsyncAwaitExample
//
//  Created by 민성홍 on 2023/05/24.
//

import Foundation

// T can be any set of data (Model struct in our case) that conforms to the Codable protocol
// For us: T = Model

final class ViewModel<T: Codable>: ObservableObject {
    enum Status {
        case loading
        case loaded(T)
        case error(Error)
    }

    @Published var status: Status = .loading

    let service = Service<T>()

    func getData() async {
        do {
            let data: T = try await service.getData()

            DispatchQueue.main.async {
                self.status = .loaded(data)
            }
        } catch {
            // Updating view altering data (@Published) has to be done asynchronous
            DispatchQueue.main.async {
                self.status = .error(error)
            }
        }
    }
}

class Service<T: Codable> {
    func getData() async throws -> T {
        // https://jsonplaceholder.typicode.com/todos/1

        let urlString: String = "https://jsonplaceholder.typicode.com/todos"
        let request = URLRequest(url: URL(string: urlString)!)
        let (data, _) = try await URLSession.shared.data(for: request)

        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)

            return decoded
        } catch {
            throw error
        }
    }
}
