//
//  FilterViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 31.07.2021.
//

import UIKit

protocol FilterViewModel {

    var output: FilterViewModelOutput? { get set }
    var filterButtons: [UIButton] { get }
    var listener: FilterViewModelListener? { get set }
//    associatedtype FilterType: RawRepresentable & CaseIterable where FilterType.RawValue: StringProtocol
//
//    func index(of type: FilterType) -> Int
//    func allParameters(for type: FilterType) -> [String]
//    func selectedItem(for type: FilterType) -> String
//    func set(value: String, for type: FilterType)
//    func title(for type: FilterType) -> String
}

protocol FilterViewModelOutput: AnyObject {
    func update(button: UIButton, at index: Int)
}

protocol FilterViewModelListener: AnyObject {
    func filterDidUpdated(object: Any)
}
