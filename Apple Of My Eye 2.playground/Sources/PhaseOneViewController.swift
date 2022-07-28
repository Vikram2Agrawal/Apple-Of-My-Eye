//
//  PhaseOneViewController.swift
//  Apple Of My Eye
//
//  Created by Vikram Agrawal on 3/23/19.
//  Copyright © 2019 Vikram Agrawal. All rights reserved.
//

import Foundation
import PlaygroundSupport
import SpriteKit
import ARKit
import UIKit

public class PhaseOneViewController: UIViewController{
    //var introScene:IntroScene!
    
    var introScene = IntroScene(fileNamed: "Intro")
    
    let sceneView = SKView(frame: CGRect(x:0 , y:0, width: 480, height: 640))
    
    public override func loadView() {
        
        self.view = sceneView
        let newFrame = CGRect(x: self.view.frame.origin.x, y: self.view.frame.origin.y, width: 480.0, height: 640.0)
        
        self.view.frame = newFrame
        //var firstTransition = SKTransition.doorsOpenVertical(withDuration: 1.5)
        
        introScene!.scaleMode = .aspectFill
        
        sceneView.presentScene(introScene)
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.view.frame.height)
        print(self.view.frame.width)
    }
    /*
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.present(trainingViewController(), animated: true, completion: nil)
        print("touches began")
    }
    */
}

