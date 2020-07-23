//
//  model.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

struct Main:Codable {
    var data:[Content]
    var view:[String]
}

struct Content:Codable {
    var name:String
    var data:DataUIElements
}

struct DataUIElements:Codable {
    var text:String?
    var url:String?
    var selectedId:Int?
    var variants:[Variants]?
}

struct Variants:Codable {
    var id:Int
    var text:String
}
