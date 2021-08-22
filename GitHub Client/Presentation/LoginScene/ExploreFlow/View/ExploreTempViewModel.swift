//
//  ExploreTempViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 22.08.2021.
//

import UIKit

protocol ExploreTempViewModelInput {
    func viewDidLoad()
}

protocol ExploreTempViewModelOutput {}

typealias ExploreTempViewModel = ExploreTempViewModelInput & ExploreTempViewModelOutput

final class ExploreTempViewModelImpl: ExploreTempViewModel {}

// MARK: - Input
extension ExploreTempViewModelImpl {
    func viewDidLoad() {}
}
