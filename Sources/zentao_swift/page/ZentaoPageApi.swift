//
//  File.swift
//  
//
//  Created by 刘斌斌 on 2022/11/6.
//

import Foundation
import Logging

struct ZentaoPageApi{
    let logger = Logger(label:"ZentaoPageApi")
    var url:URL
    init(url: URL) {
        self.url = url
    }
    var request = ZentaoRequest()

}
