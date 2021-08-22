//
//  SettingsViewModel.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import UIKit

class SettingsViewModelold {
    
    let items: [[Any]]
    
    init() {
        var firstSectionItems: [Any] = []
        
        let appearenceCell = TableCellViewModel(text: "Appearance")
        firstSectionItems.append(appearenceCell)
        
        if UIApplication.shared.supportsAlternateIcons {
            let appIconCell = TableCellViewModel(text: "App Icon")
            firstSectionItems.append(appIconCell)
        }
        
        let languageCell = TableCellViewModel(text: "Language", detailText: "Русский")
        firstSectionItems.append(languageCell)
        
        var secondSectionItems: [Any] = []
        
        let termsOfServiceCell = TableCellViewModel(text: "Terms of Service")
        secondSectionItems.append(termsOfServiceCell)

        let privacyPolicyCell = TableCellViewModel(text: "Privacy Policy")
        secondSectionItems.append(privacyPolicyCell)
        
        var thirdSectionItems: [Any] = []

        let manageAccountsCell = TableCellViewModel(text: "Manage Accounts")
        thirdSectionItems.append(manageAccountsCell)

        let codeOptionsCell = TableCellViewModel(text: "Code Options")
        thirdSectionItems.append(codeOptionsCell)

        var fourthSectionItems: [Any] = []

        let developerCell = TableCellViewModel(text: "Developer")
        fourthSectionItems.append(developerCell)

        items = [firstSectionItems, secondSectionItems, thirdSectionItems, fourthSectionItems]
    }
}
