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
    case interestingNewest = "Newest interesting"
    case interestingOldest = "Oldest interesting"
}

extension SortRule {
    func getSortRule() -> String {
        var returnValue = ""
        switch self {
        case .relevance:
            returnValue = "relevance"
        case .dateTakenNewest:
            returnValue = "date-taken-asc"
        case .dateTakenOldest:
            returnValue = "date-taken-desc"
        case .interestingNewest:
            returnValue = "interestingness-asc"
        case .interestingOldest:
            returnValue = "interestingness-desc"
        }
        return returnValue
    }
}
