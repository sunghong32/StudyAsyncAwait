//
//  DataView.swift
//  AsyncAwaitExample
//
//  Created by 민성홍 on 2023/05/24.
//

import SwiftUI

struct DataView: View {
    let data: [Model]

    var body: some View {
        List(data) { datum in
            Text(datum.title)
            Text("\(datum.userId)")
            Text(datum.completed ? "true" : "false")
        }
        .listStyle(.plain)
    }
}
