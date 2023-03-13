//
//  Emoticon.swift
//  Emoticon Dictionary
//
//  Created by Juliana Nielson on 3/7/23.
//

import Foundation

struct Emoticon: Codable, Equatable{
    var symbol: String
    var name: String
    var description: String
    var usage: String
}
