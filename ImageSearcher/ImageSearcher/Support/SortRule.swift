//
//  SortRules.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import Foundation


enum SortRule: String, CaseIterable {
    case relevance = "Relevance"
    case dateTakenNewest = "Newest by date"
    case dateTakenOldest = "Oldest by date"
    case interestingNewest = "More popular"
    case interestingOldest = "Less popular"
}

extension SortRule {
    func getSortRule() -> String {
        var returnValue = ""
        switch self {
        case .relevance:
            returnValue = "relevance"
        case .dateTakenNewest:
            returnValue = "date-taken-desc"
        case .dateTakenOldest:
            returnValue = "date-taken-asc"
        case .interestingNewest:
            returnValue = "interestingness-asc"
        case .interestingOldest:
            returnValue = "interestingness-desc"
        }
        return returnValue
    }
}
