//
//  PhaseTwoViewController.swift
//  Apple Of My Eye
//
//  Created by Vikram Agrawal on 3/23/19.
//  Copyright © 2019 Vikram Agrawal. All rights reserved.
//

import Foundation
import PlaygroundSupport
import SpriteKit
import SceneKit
import ARKit
import UIKit

public class PhaseTwoViewController: UIViewController, ARSessionDelegate, ARSKViewDelegate{
    
    var sceneView:ARSKView!
    
    var scene = PhaseTwoScene(fileNamed: "PhaseTwo")
    
    var spawnedAlready = false
    
    
    public override func loadView() {
        
        sceneView = ARSKView(frame: CGRect(x:0 , y:0, width: 480, height: 640))
        //spriteView.presentScene(spriteScene)
        
        
        

        // Set the view's delegate
        sceneView.delegate = self
        sceneView.session.delegate = self
   
        sceneView.presentScene(scene)
        
        self.view = sceneView
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        print(self.view.frame.height)
        print(self.view.frame.width)
        
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

    }
    
    
    
    
    public func session(_ session: ARSession,
                 didFailWithError error: Error) {
        print("Session Failed - probably due to lack of camera access")
    }
    
    public func sessionWasInterrupted(_ session: ARSession) {
        print("Session interrupted")
    }
    
    public func sessionInterruptionEnded(_ session: ARSession) {
        print("Session resumed")
        sceneView.session.run(session.configuration!,
                              options: [.resetTracking,
                                        .removeExistingAnchors])
    }
    
    
    

}
