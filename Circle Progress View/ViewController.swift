//
//  ViewController.swift
//  Circle Progress View
//
//  Created by Fahim Rahman on 2/2/20.
//  Copyright © 2020 Fahim Rahman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBOutlet weak var label: UILabel!
    
    var timer = Timer()
    var progress = 0
    
    let shapeLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let center = view.center
        label.center = view.center
        // create track layer
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 90, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = UIColor.black.cgColor
        trackLayer.lineWidth = 11
        trackLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(trackLayer)
        
        // create path layer
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.systemTeal.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        shapeLayer.lineCap = .round
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        view.layer.addSublayer(shapeLayer)
        
        label.text = "\(progress) %"
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    @objc private func handleTap() {
        print("Tapping")
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 8
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        shapeLayer.add(basicAnimation, forKey: "fahim")
        
        timer = Timer.scheduledTimer(timeInterval: 0.062, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    @objc func updateProgress(){
        progress += 1
        label.text = "\(progress) %"
        if progress == 100 {
            timer.invalidate()
            progress = 0
        }
    }
}
