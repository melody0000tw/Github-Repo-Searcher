
//  Repository.swift
//  Github-Repo-Searcher
//
//  Created by Melody Lee on 2024/6/19.


import Foundation

struct Repositories: Codable {
    let totalCount: Int?
    let incompleteResults: Bool?
    let items: [Item]?

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case incompleteResults = "incomplete_results"
        case items = "items"
    }
}

struct Item: Codable {
    let id: Int?
    let fullName: String?
    let owner: Owner?
    let description: String?
    let stars: Int?
    let watchers: Int?
    let forks: Int?
    let openIssues: Int?
    let language: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case fullName = "full_name"
        case owner = "owner"
        case description = "description"
        case stars = "stargazers_count"
        case watchers = "watchers"
        case forks = "forks"
        case openIssues = "open_issues"
        case language = "language"
    }
    
}

struct Owner: Codable {
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
}
