//
//  NetworkError.swift
//  FetchImage
//
//  Created by 민성홍 on 2023/05/25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case unableToConvertDataIntoImage
}
