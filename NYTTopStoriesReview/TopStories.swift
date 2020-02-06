//
//  TopStories.swift
//  NYTTopStoriesReview
//
//  Created by Oscar Victoria Gonzalez  on 2/6/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import Foundation

struct TopStories: Codable {
    let sections: String
    let lastUpdated: String
    let results: [Stories]
    private enum CodingKeys: String, CodingKey {
        case sections
        case lastUpdated = "last_updated"
        case results
    }
}

struct Stories: Codable {
    let section: String
    let title: String
    let abstract: String
    let publishedDate: String
    let multimedia: [Multimedia]
    private enum CodingKeys: String, CodingKey {
        case section
        case title
        case abstract
        case publishedDate = "published_date"
        case multimedia
    }
    
}
    
struct Multimedia: Codable {
        let url: String
        let format: String
        let heigth: Double
        let width: Double
        let caption: String
    }
    

