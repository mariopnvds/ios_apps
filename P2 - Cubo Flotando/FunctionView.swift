//
//  FunctionView.swift
//  P2 - Cubo Flotando
//
//  Created by Mario Penavades on 19/9/18.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

struct FunctionPoint{
    var x = 0.0
    var y = 0.0
}

protocol FunctionViewDataSource: class {
    func startIndexFor(_ functionView: FunctionView) -> Double //valor inicial (ej: inicio en 0 seg)
    func endIndexFor(_ functionView: FunctionView) -> Double // valor final (ej: termino en 5 seg)
    func functionView(_ functionView: FunctionView, pointAt index: Double) -> FunctionPoint
    func pointsOfInterestFor(_ functionView: FunctionView) -> FunctionPoint
    func getAxisLabels(_ functionView: FunctionView) -> [String]
}
class FunctionView: UIView {
    
    var dataSource: FunctionViewDataSource!
    
    var textY = "Eje Y"
    var textX = "Tiempo"
    @IBInspectable
    var scaleX : Double = 10.0
    @IBInspectable
    var scaleY : Double = 10.0
    @IBInspectable
    var lw : Double = 1.0
    @IBInspectable
    var color : UIColor = UIColor.blue
    
    private func drawAxis(){
        let width = bounds.size.width
        let height = bounds.size.height
        
        let path1 = UIBezierPath()
        path1.move(to: CGPoint(x: width/2, y: 0))
        path1.addLine(to: CGPoint(x: width/2, y: height))
        
        let path2 = UIBezierPath()
        path2.move(to: CGPoint(x: 0, y: height/2))
        path2.addLine(to: CGPoint(x: width, y: height/2))
        
        path1.lineWidth = 1
        path1.stroke()
        path2.lineWidth = 1
        path2.stroke()
    }
    
    private func drawFunc(){
        let path = UIBezierPath()
        
        let startTime = dataSource.startIndexFor(self)
        let endTime = dataSource.endIndexFor(self)
        var punto = dataSource.functionView(self, pointAt: startTime)
        let midTime = 0.01
        
        var x0 = pointX(punto.x)
        var y0 = pointY(punto.y)
        
        path.move(to: CGPoint(x: x0, y: y0))
        
        for i in stride(from: startTime, to: endTime, by: midTime){
            punto = dataSource.functionView(self, pointAt: i)
            x0 = pointX(punto.x)
            y0 = pointY(punto.y)
            path.addLine(to: CGPoint(x: x0, y: y0))
        }
        path.lineWidth = CGFloat(lw)
        color.setStroke()
        path.stroke()
    }
    
    private func drawImPoint() {
        let punto = dataSource.pointsOfInterestFor(self)
        let punto_x = pointX(punto.x)
        let punto_y = pointY(punto.y)
        
        let p1 = CGRect(x: punto_x-3, y: punto_y-3, width: 5.0, height: 5.0)
        let point1 = UIBezierPath(ovalIn: p1)
        UIColor.blue.setStroke()
        point1.stroke()
        UIColor.blue.setFill()
        point1.fill()
    }
    
    private func drawLabels(){
        textX = dataSource.getAxisLabels(self)[1]
        textY = dataSource.getAxisLabels(self)[0]
        let width = bounds.size.width
        let height = bounds.size.height
        let attrs = [NSAttributedStringKey.font: UIFont.systemFont(ofSize:12)]
        let offset : CGFloat = 4
        
        let asX = NSAttributedString(string: textX, attributes: attrs)
        let posX = CGPoint(x: offset, y: height/2 + offset)
        asX.draw(at: posX)
        
        let asY = NSAttributedString(string: textY, attributes: attrs)
        let sizeY = asY.size()
        let posY = CGPoint(x: width/2 - offset - sizeY.width, y: offset)
        asY.draw(at: posY)
    }
    
    private func pointX(_ vx: Double) -> CGFloat{
        let width = bounds.size.width
        return width/2 + CGFloat(scaleX*vx)
    }
    
    private func pointY(_ vy : Double) -> CGFloat{
        let height = bounds.size.height
        return height/2 + CGFloat(scaleY*vy)
    }
    
    override func draw(_ rect: CGRect) {
        drawAxis()
        drawFunc()
        drawImPoint()
        drawLabels()
    }
}
