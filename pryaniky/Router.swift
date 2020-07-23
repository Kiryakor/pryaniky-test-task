//
//  Router.swift
//  pryaniky
//
//  Created by Кирилл on 22.07.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

protocol RoutetMain {
    var bilder:Builder { get set }
}

protocol RouterProtocol: RoutetMain {}
 
class Router:RouterProtocol{
    
    var bilder: Builder
    
    init(bilder:Builder) {
        self.bilder = bilder
    }
}
