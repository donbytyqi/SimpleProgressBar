//
//  ViewController.swift
//  ProgressBar
//
//  Created by Don Bytyqi on 10/3/18.
//  Copyright © 2018 Don Bytyqi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var progressBar: SimpleProgressBar = {
        let pb = SimpleProgressBar(progressColor: .red, borderColor: .clear, borderWidth: 1.5)
        pb.translatesAutoresizingMaskIntoConstraints = false
        pb.roundedCorners = true
        pb.gradient = [UIColor.init(red: 153 / 255, green: 51 / 255, blue: 255 / 255, alpha: 1.0), UIColor.init(red: 127 / 255, green: 0 / 255, blue: 255 / 255, alpha: 1.0)]
        return pb
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .black
        self.view.addSubview(progressBar)
        
        progressBar.progress = 0.5
        progressBar.gradientAngle = .topRightBottomLeft
        
        progressBar.widthAnchor.constraint(equalToConstant: 250).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        progressBar.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        progressBar.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(randomlyChangeProgressBar))
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func randomlyChangeProgressBar() {
        let randomValue = Double.random(in: 0.0...1.0)
        progressBar.progress = CGFloat(randomValue)
    }
    
}

