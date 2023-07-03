//
//  File.swift
//  
//
//  Created by 刘斌斌 on 2022/11/6.
//

import Foundation
import Logging

public struct ZentaoPageApi{
    let logger = Logger(label:"ZentaoPageApi")
    var url:URL
    public init(url: URL) {
        self.url = url
    }
    var request = ZentaoRequest()
    var isLogined:Bool = false
}
