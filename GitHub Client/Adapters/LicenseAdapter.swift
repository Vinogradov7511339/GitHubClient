//
//  LicenseAdapter.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 21.07.2021.
//

import Foundation

class LicenseAdapter {
    
    static func toDBModel(_ dbRepository: LicenseDBModel, from repository: License) {
        fatalError()
    }
    
    static func fromDBModel(_ license: LicenseDBModel) -> License {
        return License(
            key: license.key,
            name: license.name,
            url: license.url,
            spdx_id: license.spdx_id,
            node_id: license.node_id,
            html_url: license.html_url
        )
    }
}
