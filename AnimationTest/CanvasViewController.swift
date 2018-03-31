//
//  CanvasViewController.swift
//  AnimationTest
//
//  Created by Henry Vuong on 3/31/18.
//  Copyright © 2018 Henry Vuong. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    
    var trayOriginalCenter: CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        trayDownOffset = 185
        trayUp = trayView.center // The initial position of the tray
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset) // The position of the tray transposed down
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            let velocity = sender.velocity(in: view)
            if velocity.y > 0 {
                UIView.animate(withDuration:0.4, animations: {
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animate(withDuration: 0.4, animations: {
                    self.trayView.center = self.trayUp
                })
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        
        
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            // properties to allow future changing of the faces on the canvas
            newlyCreatedFace.isUserInteractionEnabled = true
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.didPanFaceCanvas(_:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {

        }
        
    }
    
    @objc func didPanFaceCanvas(_ sender: UIPanGestureRecognizer) {
        let location = sender.location(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            newlyCreatedFace = sender.view as! UIImageView // to get the face that we panned on.
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center // so we can offset by translation later.
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
        }
    }
    
    
}
