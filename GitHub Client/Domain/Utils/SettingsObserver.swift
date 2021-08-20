//
//  SettingsObserver.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 19.08.2021.
//

struct CodeOptions {
    var showLineNumbers: Observable<Bool>
    var forceDarkMode: Observable<Bool>
    var lineWrapping: Observable<Bool>
}
