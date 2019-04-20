//
//  ParamModel.swift
//  P2 - Cubo Flotando
//
//  Created by Mario Penavades on 19/9/18.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import Foundation

class ParamModel {
    static var g = 9.8
    private var w : Double = 0
    var l: Double = 0.3 {
        didSet{
            updateW()
        }
    }
    
    init() {
        updateW()
    }
    
    private func updateW(){
        w = sqrt(2*ParamModel.g/l)
    }
    
    func accelerationAtTime(_ t: Double) -> Double{
        return -ParamModel.g*cos(w*t)
    }
    func speedAtTime(_ t: Double) -> Double{
        return -0.5*l*w*sin(w*t)
    }
    func positionAtTime(_ t: Double) -> Double{
        return 0.5*l*cos(w*t)
    }
}
