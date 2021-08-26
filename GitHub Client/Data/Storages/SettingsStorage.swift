//
//  SettingsStorage.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 24.07.2021.
//

import Foundation

protocol SettingsStorage {
    var codeOptions: CodeOptions { get }
}

class SettingsStorageImpl: SettingsStorage {

    static let shared = SettingsStorageImpl()

    // MARK: - SettingsStorage
    var codeOptions: CodeOptions

    // MARK: - Lifecycle
    private init() {
        codeOptions = SettingsStorageImpl.loadCodeOptions()
        codeOptions.forceDarkMode.observe(on: self) { self.saveForceDarkMode($0) }
        codeOptions.showLineNumbers.observe(on: self) { self.saveLineNumbers($0) }
        codeOptions.lineWrapping.observe(on: self) { self.saveLineWrapping($0) }
    }

    func saveForceDarkMode(_ newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: "CodeOptions_ForceDarkMode")
    }

    func saveLineNumbers(_ newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: "CodeOptions_LineNumbers")
    }

    func saveLineWrapping(_ newValue: Bool) {
        UserDefaults.standard.set(newValue, forKey: "CodeOptions_LineWrapping")
    }

    private static func loadCodeOptions() -> CodeOptions {
        let showLineNumbers = UserDefaults.standard.bool(forKey: "CodeOptions_LineNumbers")
        let forceDarkMode = UserDefaults.standard.bool(forKey: "CodeOptions_ForceDarkMode")
        let lineWrapping = UserDefaults.standard.bool(forKey: "CodeOptions_LineWrapping")

        return CodeOptions(showLineNumbers: Observable(showLineNumbers),
                           forceDarkMode: Observable(forceDarkMode),
                           lineWrapping: Observable(lineWrapping))
    }
}
