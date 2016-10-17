//
//  gameOfThrones.swift
//  AC3.2-GameOfThrones
//
//  Created by Karen Fuentes on 10/12/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation


class GOTEpisode {
    let name: String
    let number: Int
    let airdate: String
    let season: Int
    let image: String
    let summary: String
    
    init(name: String, number: Int, airdate: String, season: Int, image: String, summary: String) {
        self.name = name
        self.number = number
        self.airdate = airdate
        self.season = season
        self.image = image
        self.summary = summary
    }
    
    convenience init?(withDict dict: [String:Any]) {
        if let name = dict["name"] as? String,
            let number = dict["number"] as? Int,
            let airdate = dict["airdate"] as? String,
            let season = dict["season"] as? Int,
            let imageDict = dict["image"] as? [String:String],
            let image = imageDict["medium"],
            let summary = dict["summary"] as? String
        {
            
            
            let summaryWithoutTags = summary.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            
            self.init(name: name, number: number, airdate: airdate, season:season, image:image, summary:summaryWithoutTags)
        }
        else {
            return nil
        }
    }
}

