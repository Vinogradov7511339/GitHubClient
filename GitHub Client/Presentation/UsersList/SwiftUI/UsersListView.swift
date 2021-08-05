//
//  UsersListView.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 05.08.2021.
//

import UIKit
import SwiftUI


final class UsersListViewModelWrapper: ObservableObject {
    var viewModel: UsersListViewModelImpl?
    @Published var items: [User] = []
    
    init(viewModel: UsersListViewModelImpl?) {
        self.viewModel = viewModel
        viewModel?.items.observe(on: self) { [weak self] values in self?.items = values }
    }
}

struct RepositoriesListContainer: View {
    @ObservedObject var viewModel: UsersListViewModelWrapper

    var body: some View {
        UsersListView(
            users: viewModel.items
//            isLoading: viewModel.state.canLoadNextPage,
//            onScrolledAtBottom: viewModel.fetchNextPageIfPossible
        )
        .onAppear(perform: viewModel.viewModel?.didLoadNextPage)
    }
}

struct UsersListView: View {
    let users: [User]
//    let isLoading: Bool
//    let onScrolledAtBottom: () -> Void

    var body: some View {
        List {
            usersList
//            if isLoading {
//                loadingIndicator
//            }
        }
    }

    private var usersList: some View {
        ForEach(users) { user in
            UserRow(user: user).onAppear {
                if self.users.last == user {
//                    self.onScrolledAtBottom()
                }
            }
        }
    }
    private var loadingIndicator: some View {
        Spinner(style: .medium)
            .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct UserRow: View {
    let user: User
    var body: some View {
        VStack {
            if let name = user.name {
                Text(name).font(.title)
            }
            Text(user.login).font(.subheadline)
            if let bio = user.bio {
                Text(bio)
            }
        }
        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
    }
}

struct Spinner: UIViewRepresentable {
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: style)
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {}
}
