//
//  APIService.swift
//  FetchImage
//
//  Created by 민성홍 on 2023/05/25.
//

import Foundation
import UIKit

class APIService {
    let baseURL = "https://api.unsplash.com/photos/random/?client_id=acceesKey"

    func fetchImage() async throws -> UIImage {
        guard let imageURL = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: imageURL)
        guard let image = UIImage(data: data) else {
            print("\(response)")
            throw NetworkError.unableToConvertDataIntoImage
        }

        return image
    }
}
