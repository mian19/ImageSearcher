//
//  AlertMessage.swift
//  ImageSearcher
//
//  Created by Kyzu on 30.11.22.
//

import Foundation

enum AlertMessage: String {
    case ok = "ok"
    case alredyTag = "This tag alredy added"
    case emptyTag = "Tag can't be empty"
    case emptyResult = "Try to use another tags"
    case needAddTag = "Please select at least 1 tag first"
}
