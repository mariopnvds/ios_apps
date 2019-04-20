//
//  ViewController.swift
//  P2 - Cubo Flotando
//
//  Created by Mario Penavades on 19/9/18.
//  Copyright © 2018 Mario Penavades. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FunctionViewDataSource {
    var model : ParamModel!
    var trajectoryTime : Double = 0.0{
        didSet{
            grafica1View.setNeedsDisplay()
            grafica2View.setNeedsDisplay()
            grafica3View.setNeedsDisplay()
            grafica4View.setNeedsDisplay()
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ladoLabel: UILabel!
    @IBOutlet weak var ladoDataLabel: UILabel!
    @IBOutlet weak var tiempoDataLabel: UILabel!
    
    @IBOutlet weak var grafica1View: FunctionView!
    @IBOutlet weak var grafica2View: FunctionView!
    @IBOutlet weak var grafica3View: FunctionView!
    @IBOutlet weak var grafica4View: FunctionView!
    @IBOutlet weak var tiempoLabel: UILabel!
    @IBOutlet weak var ladoSlider: UISlider!
    @IBOutlet weak var tiempoSlider: UISlider!
    
    @IBAction func ladoSlider(_ sender: UISlider) {
        model.l = Double(sender.value)
        ladoDataLabel.text = "\(model.l.description) m"
        grafica1View.setNeedsDisplay()
        grafica2View.setNeedsDisplay()
        grafica3View.setNeedsDisplay()
        grafica4View.setNeedsDisplay()
    }
    @IBAction func tiempoSlider(_ sender: UISlider) {
        trajectoryTime = Double(sender.value)
        tiempoDataLabel.text = "\(trajectoryTime.description) seg"
        grafica1View.setNeedsDisplay()
        grafica2View.setNeedsDisplay()
        grafica3View.setNeedsDisplay()
        grafica4View.setNeedsDisplay()
    }
    
    @IBAction func zoomGrafica4(_ sender: UIPinchGestureRecognizer) {
        model.l *= Double(sender.scale)
        ladoSlider.value = Float(model.l)
        ladoDataLabel.text = "\(model.l.description) m"
        sender.scale = 1.0
        grafica1View.setNeedsDisplay()
        grafica2View.setNeedsDisplay()
        grafica3View.setNeedsDisplay()
        grafica4View.setNeedsDisplay()
    }
    
    @IBAction func swipeRightGRafica1(_ sender: UISwipeGestureRecognizer) {
        model.l += 0.1
        ladoSlider.value = Float(model.l)
        ladoDataLabel.text = "\(model.l.description) m"
        grafica1View.setNeedsDisplay()
        grafica2View.setNeedsDisplay()
        grafica3View.setNeedsDisplay()
        grafica4View.setNeedsDisplay()
    }
    
    @IBAction func swipeLeftgrafica1(_ sender: UISwipeGestureRecognizer) {
        model.l -= 0.1
        ladoSlider.value = Float(model.l)
        ladoDataLabel.text = "\(model.l.description) m"
        grafica1View.setNeedsDisplay()
        grafica2View.setNeedsDisplay()
        grafica3View.setNeedsDisplay()
        grafica4View.setNeedsDisplay()
    }
    
    @IBAction func swipeUpGrafica4(_ sender: UISwipeGestureRecognizer) {
        trajectoryTime += 0.2
        tiempoSlider.value = Float(trajectoryTime)
        tiempoDataLabel.text = "\(trajectoryTime.description) seg"
        grafica1View.setNeedsDisplay()
        grafica2View.setNeedsDisplay()
        grafica3View.setNeedsDisplay()
        grafica4View.setNeedsDisplay()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = ParamModel()
        grafica1View.dataSource = self
        grafica1View.scaleX = 20
        grafica1View.scaleY = 80
        grafica2View.dataSource = self
        grafica2View.scaleX = 20
        grafica2View.scaleY = 18
        grafica3View.dataSource = self
        grafica3View.scaleX = 20
        grafica3View.scaleY = 3
        grafica4View.dataSource = self
        grafica4View.scaleX = 250
        grafica4View.scaleY = 50
        ladoDataLabel.text = "\(model.l.description) m"
        tiempoDataLabel.text = "\(trajectoryTime.description) seg"
        tiempoSlider.sendActions(for: .valueChanged)
        ladoSlider.sendActions(for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getAxisLabels(_ functionView: FunctionView) -> [String] {
        switch functionView {
        case grafica1View:
            return ["Posicion Z", "Tiempo"]
        case grafica2View:
            return ["Velocidad", "Tiempo"]
        case grafica3View:
            return ["Aceleracion", "Tiempo"]
        case grafica4View:
            return ["Velocidad", "Posicion Z"]
        default:
            return ["Eje X", "Eje Y"]
        }
    }
    
    func startIndexFor(_ functionView: FunctionView) -> Double {
        return 0.0
    }
    
    func endIndexFor(_ functionView: FunctionView) -> Double {
        return 20.0
    }
    
    func functionView(_ functionView: FunctionView, pointAt index: Double) -> FunctionPoint {
        switch functionView{
        case grafica1View:
            let x = index
            let y = model.positionAtTime(index)
            return FunctionPoint(x: x, y: y)
        case grafica2View:
            let x = index
            let y = model.speedAtTime(index)
            return FunctionPoint(x: x, y: y)
        case grafica3View:
            let x = index
            let y = model.accelerationAtTime(index)
            return FunctionPoint(x: x, y: y)
        case grafica4View:
            let x = model.positionAtTime(index)
            let y = model.speedAtTime(index)
            return FunctionPoint(x: x, y: y)
        default:
            return FunctionPoint(x: 0.0, y: 0.0)
        }
    }
    
    func pointsOfInterestFor(_ functionView: FunctionView) -> FunctionPoint {
        let time = trajectoryTime
        switch functionView {
        case grafica1View: // Posicion
            let x = time
            let y = model.positionAtTime(time)
            return FunctionPoint(x: x, y: y)
        case grafica2View: // Velocidad
            let x = time
            let y = model.speedAtTime(time)
            return FunctionPoint(x: x, y: y)
        case grafica3View: // Aceleracion
            let x = time
            let y = model.accelerationAtTime(time)
            return FunctionPoint(x: x, y: y)
        case grafica4View: // Sistema completo
            let x = model.positionAtTime(time)
            let y = model.speedAtTime(time)
            return FunctionPoint(x: x, y: y)
        default:
            return FunctionPoint(x: 0, y: 0)
        }
    }
}

