//
//  ContentView.swift
//  AsyncAwaitExample
//
//  Created by 민성홍 on 2023/05/24.
//

import SwiftUI

struct ContentView: View {
    // Here we declare what 'T' will be: Model
    @ObservedObject private var viewModel: ViewModel<[Model]> = .init()

    var body: some View {
        Group {
            switch viewModel.status {
                case .loading:
                    loadingView()
                case .loaded(let data):
                    loadedView(data: data)
                case .error(let error):
                    errorView(error: error)
            }
        }
        .task {
            await viewModel.getData()
        }
    }

    @ViewBuilder
    func loadingView() -> some View {
        Text("Loading...")
    }

    @ViewBuilder
    func loadedView(data: [Model]) -> some View {
        DataView(data: data)
    }

    @ViewBuilder
    func errorView(error: Error) -> some View {
        Text("Error: \(error.localizedDescription)")
    }
}
