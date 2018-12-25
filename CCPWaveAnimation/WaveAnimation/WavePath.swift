//
//  WavePath.swift
//  WaveView
//
//  Created by 储诚鹏 on 2018/12/24.
//  Copyright © 2018 储诚鹏. All rights reserved.
//

import UIKit

class WavePath {
    private let width: Int
    private let height: Int
    
    private init(_ size: CGSize) {
        self.width = Int(size.width)
        self.height = Int(size.height)
    }
    
    static func path(_ size: CGSize, _ offset: Double = 0) -> CGMutablePath {
        return WavePath(size).drawPath(offset)
    }
    
    private func drawPath(_ offset: Double = 0) -> CGMutablePath {
        let path = CGMutablePath()
        let line = WaveLine(Double(width / 2), Double(height), offset)
        path.move(to: CGPoint(x: 0, y: height))
        for x in 1 ..< width + 1 {
            let x = Double(x)
            let y = line.sine(x)
            path.addLine(to: CGPoint(x: x, y: y))
        }
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        path.closeSubpath()
        return path
    }
}

/*
 *y=Asin(ωx+φ)+k
 * amplitude: 振幅
 * phase: 初相
 * palstance: 角速度
 * setover: 偏距
 */

struct WaveLine {
    let amplitude: Double
    let phase: Double
    let palstance: Double
    let setover: Double
    
    init(_ palstance: Double, _ amplitude: Double, _ phase: Double = 0, _ setover: Double = 0) {
        self.amplitude = amplitude
        self.phase = phase
        self.palstance = Double.pi * 2 / palstance
        self.setover = setover
    }
}

extension WaveLine {
    
    func cosine(_ x: Double) -> Double {
        return amplitude * cos(palstance * x + phase) + setover
    }
    
    func sine(_ x: Double) -> Double {
        return amplitude * sin(palstance * x + phase) + setover
    }
    
}
