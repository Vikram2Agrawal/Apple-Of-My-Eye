//
//  LevelUpScene.swift
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

public class TotalEarningsScene: SKScene {
    
    var youMadeLabel:SKLabelNode!
    
    var numPiesLabel:SKLabelNode!
    var numPies = 0
    
    var playAgainLabel:SKLabelNode!
    
    var levelNumber = 1
    var motionLevelNumber = 1
    
    var pulsateNextLevelLabel:SKAction!

    
    public override func didMove(to view: SKView) {
        
        let mainFont = Bundle.main.url(forResource: "BadaBoomBB", withExtension: "TTF")! as CFURL
        CTFontManagerRegisterFontsForURL(mainFont, CTFontManagerScope.process, nil)
        
        let youMadeFont = Bundle.main.url(forResource: "HoboStd", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(youMadeFont, CTFontManagerScope.process, nil)
        
        youMadeLabel = childNode(withName: "youMade") as? SKLabelNode
        numPiesLabel = childNode(withName: "numPies") as? SKLabelNode
        playAgainLabel = childNode(withName: "playAgain") as? SKLabelNode
        
        numPies = getTotNumPies()
        print(numPies)
        
        numPiesLabel.text = "\(numPies)"
    
        youMadeLabel.fontName = "HoboStd"
        
        pulsateNextLevelLabel = SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.playAgainLabel.color = UIColor.orange
            }, SKAction.wait(forDuration: 0.5), SKAction.run {
                self.playAgainLabel.color = UIColor.white
            }]))
        
        self.run(pulsateNextLevelLabel)
            
            
        
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if (name == "playAgain"){
                
                        let first = PhaseOneViewController()
                        
                        let navController = UINavigationController(rootViewController: first)
                        
                        let newFrame = CGRect(x: navController.view.frame.origin.x, y: navController.view.frame.origin.y, width: 480.0, height: 640.0)
                        navController.view.frame = newFrame
                        
                        print(navController.view.frame.height)
                        print(navController.view.frame.width)
                        
                        first.navigationController?.isNavigationBarHidden = true
                        first.navigationController?.isToolbarHidden = true
                        
                        
                        PlaygroundPage.current.liveView = navController
                //self.present(PhaseTwoViewController(), animated: true, completion: nil)
                
            }
        }
    }
    

}
