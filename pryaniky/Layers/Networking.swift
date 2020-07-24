//
//  Layers.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import Foundation

class Networking{
    static func loadData(URL:URL,complition:@escaping(Data?,URLResponse?,Error?)->Void){
        URLSession(configuration: .default).dataTask(with: URL) { (data, response, error) in
            complition(data,response,error)
        }.resume()
    }
    
    static func loadImage(URL:URL,complition:@escaping(Data?)->Void){
        URLSession(configuration: .default).dataTask(with: URL) { (data, response, error) in
            guard let data = data,error == nil else {
                complition(nil)
                return
            }
            complition(data)
        }.resume()
    }
}
