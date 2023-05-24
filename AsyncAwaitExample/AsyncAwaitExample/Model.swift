//
//  Model.swift
//  AsyncAwaitExample
//
//  Created by 민성홍 on 2023/05/24.
//

import Foundation

struct Model: Codable, Identifiable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
