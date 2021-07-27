//
//  Discussion.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 27.07.2021.
//

import Foundation


struct Discussion: Codable {
    let author: UserProfile?
    let body: String?
    let body_html: String?
    let body_version: String?
    let comments_count: Int?
    let comments_url: URL?
    let created_at: String?
    let last_edited_at: String?
    let html_url: String?
    let node_id: String?
    let number: Int?
    let pinned: Bool?
//    let private: Bool?
    let team_url: URL?
    let title: String?
    let updated_at: String?
    let url: URL?
    let reactions: Reactions?
}
