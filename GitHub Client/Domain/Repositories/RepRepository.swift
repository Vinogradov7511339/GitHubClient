//
//  RepRepository.swift
//  GitHub Client
//
//  Created by Alexander Vinogradov on 04.08.2021.
//

import Foundation

protocol RepRepository {
    func fetchCommits(request: CommitsRequestModel, completion: @escaping (Result<CommitsResponseModel, Error>) -> Void)
    func fetchContent(path: URL, completion: @escaping (Result<[FolderItem], Error>) -> Void)
    func fetchReadMe(repository: Repository, completion: @escaping (Result<String, Error>) -> Void)
    func fetchFile(path: URL, completion: @escaping (Result<File, Error>) -> Void)
}
