//
//  WaveView.swift
//  WaveAnimationExample
//
//  Created by 박준현 on 2022/07/02.
//

import UIKit

class WaveView: UIView {
    override class var layerClass: AnyClass {
        WaveLayer.self
    }
    
    var waveLayer: WaveLayer? {
        layer as? WaveLayer
    }
    
    @IBInspectable
    var waveColor: UIColor? {
        get {
            waveLayer?.waveColor
        }
        
        set {
            waveLayer?.waveColor = newValue
            waveLayer?.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var circleColor: UIColor? {
        get {
            waveLayer?.circleColor
        }
        
        set {
            waveLayer?.circleColor = newValue
            waveLayer?.setNeedsDisplay()
        }
    }
    
    @IBInspectable
    var waveDuration: CGFloat {
        get {
            waveLayer?.waveDuration ?? 0.3
        }
        
        set {
            waveLayer?.waveDuration = newValue
            waveLayer?.outerLayer?.removeAllAnimations()
        }
    }
    
    func startWave() {
        waveLayer?.startWave()
    }
}


class WaveLayer: CALayer {
    fileprivate var outerLayer: CAShapeLayer?
    
    fileprivate var waveColor: UIColor?
    fileprivate var circleColor: UIColor?
    fileprivate var waveDuration: CGFloat = 0.3
    
    override func draw(in ctx: CGContext) {
        let radius: CGFloat = min(self.bounds.width / 2, self.bounds.height / 2)
        let center: CGPoint = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        
        self.removeAllSubLayers()
        
        let outerLayer = makeCircleLayer(center, radius: radius, fillColor: waveColor?.cgColor)
        addSublayer(outerLayer)
        self.outerLayer = outerLayer
        
        let innerLayer = makeCircleLayer(center, radius: radius, fillColor: circleColor?.cgColor)
        addSublayer(innerLayer)
    }
    
    private func makeCircleLayer(_ center: CGPoint, radius: CGFloat, fillColor: CGColor?) -> CAShapeLayer {
        let circleLayer = CAShapeLayer()
        circleLayer.frame = self.bounds
        circleLayer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        circleLayer.position = CGPoint(x: self.bounds.width / 2, y: self.bounds.height / 2)
        circleLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: .pi * 2, clockwise: false).cgPath
        circleLayer.fillColor = fillColor
        return circleLayer
    }
    
    fileprivate func startWave() {
        outerLayer?.removeAllAnimations()
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 1.3
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        animation.autoreverses = true
        animation.duration = waveDuration
        animation.beginTime = CACurrentMediaTime()
        
        outerLayer?.add(animation, forKey: "wave")
    }
}
extension CALayer {
    func removeAllSubLayers() {
        self.sublayers?.forEach({
            $0.removeFromSuperlayer()
        })
    }
}
