//
//  ProgressBar.swift
//  ProgressBar
//
//  Created by Don Bytyqi on 10/3/18.
//  Copyright © 2018 Don Bytyqi. All rights reserved.
//

import UIKit

enum GradientAngle {
    case right
    case left
    case bottom
    case top
    case topLeftBottomRight
    case topRightBottomLeft
    case bottomLeftTopRight
    case bottomRightTopRight
}

class SimpleProgressBar: UIView {
    
    /// A value between 0.0 & 1.0 - ANIMATABLE
    var progress: CGFloat = 0.0 {
        didSet {
            updateFrame()
        }
    }
    
    private var maxWidth: CGFloat = 0.0
    private var gradientLayer: CAGradientLayer?
    
    /// Default is OFF.
    var roundedCorners: Bool = false
    
    /// Default is OFF.
    var borderColor: UIColor = .clear
    var borderWidth: CGFloat = 0.0
    
    /// Only 2 colors for now.
    var gradient: [UIColor] = []
    var gradientAngle: GradientAngle = .bottomRightTopRight
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(progressColor: UIColor, borderColor: UIColor = .clear, borderWidth: CGFloat) {
        self.init(frame: .zero)
        self.backgroundColor = progressColor
        self.borderColor = borderColor
        self.borderWidth = borderWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if self.maxWidth == 0.0 && self.bounds.width != 0.0 {
            self.maxWidth = self.bounds.width
        }
        updateFrame()
    }
    
    fileprivate func updateFrame() {
        
        let progressValue = self.progress
        if progressValue > 1.0 {
            progress = 1.0
            print("Progress value must be a value between 0.0 and 1.0 -- Reset progress to 1.0")
            return
        }
        let widthInPercentage = self.maxWidth * progressValue
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: widthInPercentage, height: self.frame.height)
        
        if roundedCorners {
            
            if !clipsToBounds { clipsToBounds = true }
            
            if progressValue < 1.0 {
                self.roundCorners(corners: [.topLeft, .bottomLeft], radius: self.frame.height / 2)
            } else {
                self.roundCorners(corners: [.topRight, .bottomRight, .topLeft, .bottomLeft], radius: self.frame.height / 2)
            }
            
        } else {
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = borderColor.cgColor
        }
        
        if gradient.count == 2 {
            addGradient()
        }
        
    }
    
}

extension SimpleProgressBar {
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        let shape = CAShapeLayer()
        shape.frame = self.bounds
        shape.path = path.cgPath
        shape.lineWidth = self.borderWidth
        shape.strokeColor = self.borderColor.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.name = "border"
        self.layer.sublayers?.forEach({
            if $0.name == "border" {
                $0.removeFromSuperlayer()
            }
        })
        self.layer.insertSublayer(shape, at: 0)
    }
    
    
    func addGradient() {
        let color1 = gradient[0].cgColor
        let color2 = gradient[1].cgColor
        
        if gradientLayer != nil {
            gradientLayer?.removeFromSuperlayer()
            gradientLayer = nil
        }
        
        gradientLayer = CAGradientLayer()
        gradientLayer?.colors = [color1, color2]
        
        switch gradientAngle {
        case .right:
            gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .left:
            gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottom:
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .top:
            gradientLayer?.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer?.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .topLeftBottomRight:
            gradientLayer?.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer?.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .topRightBottomLeft:
            gradientLayer?.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradientLayer?.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .bottomLeftTopRight:
            gradientLayer?.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradientLayer?.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .bottomRightTopRight:
            gradientLayer?.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradientLayer?.endPoint = CGPoint(x: 0.0, y: 0.0)
        }
        
        gradientLayer?.locations = [0.0, 1.0]
        gradientLayer?.frame = self.bounds
        guard gradientLayer != nil else { return }
        self.layer.insertSublayer(gradientLayer!, at: 0)
    }
    
    
}
