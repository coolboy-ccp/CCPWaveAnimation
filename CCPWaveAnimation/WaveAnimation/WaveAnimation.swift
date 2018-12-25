//
//  WaveAnimation.swift
//  WaveView
//
//  Created by 储诚鹏 on 2018/12/24.
//  Copyright © 2018 储诚鹏. All rights reserved.
//

import UIKit

fileprivate final class WaveManager {
    static let instance = WaveManager()
    var waves = [Int: WaveAnimation]()
    private init() {}
}

final class WaveAnimation {
    
    private var displayLink: CADisplayLink?
    private var path: WavePath?
    private var shapeLayer: CAShapeLayer?
    private var waveWidth: CGFloat = 0
    private var waveHeight: CGFloat = 0
    private var waveSpeed: Double = 0
    private var waveOffset: Double = 0
    private var waveColor: UIColor = .white
    
    static func start(at layer: CALayer, color: UIColor, speed: Double, height: CGFloat) {
        let hash = layer.hash
        if nil == WaveManager.instance.waves[hash] {
            let animation = WaveAnimation()
            animation.resetPragmas(color: color, speed: speed, height: height)
            WaveManager.instance.waves[hash] = animation
            animation.waveLayer(layer)
            if animation.displayLink == nil {
                animation.initDisplayLink()
            }
        }
    }
    
    static func stop(at layer: CALayer) {
        let hash = layer.hash
        if let animation = WaveManager.instance.waves[hash] {
            animation.displayLink?.invalidate()
            animation.displayLink = nil
            animation.shapeLayer?.removeFromSuperlayer()
            WaveManager.instance.waves[hash] = nil
        }
    }

    private func initDisplayLink() {
        self.displayLink = CADisplayLink(target: self, selector: #selector(waving))
        self.displayLink?.add(to: .current, forMode: .common)
    }
    
    
    
    private func resetPragmas(color: UIColor, speed: Double, height: CGFloat) {
        self.waveColor = color
        self.waveSpeed = speed
        self.waveHeight = height
    }
    
    private func waveLayer(_ sup: CALayer) {
        shapeLayer = CAShapeLayer()
        waveWidth = sup.frame.width
        shapeLayer?.frame = CGRect(x: 0, y: sup.frame.height - waveHeight, width: waveWidth, height: waveHeight)
        shapeLayer?.path = WavePath.path(CGSize(width: waveWidth, height: waveHeight))
        sup.addSublayer(shapeLayer!)
        shapeLayer?.fillColor = waveColor.cgColor
    }
    
    @objc private func waving() {
        if waveOffset > Double(waveWidth / 2) {
            waveOffset = 0
        }
        waveOffset += waveSpeed / 60
        shapeLayer?.path = WavePath.path(CGSize(width: waveWidth, height: waveHeight), waveOffset)
    }
    
}

extension UIView {
        
    func startWave(color: UIColor = .white, speed: Double = 5, height: CGFloat = 5) {
        WaveAnimation.start(at: self.layer, color: color, speed: speed, height: height)
    }
    
    func stopWave() {
        WaveAnimation.stop(at: self.layer)
    }
}
