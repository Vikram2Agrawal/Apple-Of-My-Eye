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

public class LevelUpScene: SKScene {
    
    var levelLabel:SKLabelNode!
    var levelNumLabel:SKLabelNode!
    var youMadeLabel:SKLabelNode!
    
    var numPiesLabel:SKLabelNode!
    var numPies = 0
    
    var ontoNextLevelLabel:SKLabelNode!
    
    var levelNumber = 1
    var motionLevelNumber = 1
    
    var pulsateNextLevelLabel:SKAction!

    
    public override func didMove(to view: SKView) {
        
        let mainFont = Bundle.main.url(forResource: "BadaBoomBB", withExtension: "TTF")! as CFURL
        CTFontManagerRegisterFontsForURL(mainFont, CTFontManagerScope.process, nil)
        
        let youMadeFont = Bundle.main.url(forResource: "HoboStd", withExtension: "otf")! as CFURL
        CTFontManagerRegisterFontsForURL(youMadeFont, CTFontManagerScope.process, nil)
        
        levelLabel = childNode(withName: "levelLabel") as? SKLabelNode
        levelNumLabel = childNode(withName: "levelNumLabel") as? SKLabelNode
        youMadeLabel = childNode(withName: "youMade") as? SKLabelNode
        numPiesLabel = childNode(withName: "numPies") as? SKLabelNode
        ontoNextLevelLabel = childNode(withName: "ontoNextLevel") as? SKLabelNode
        
        numPies = getLastNumOfPies()
        print(numPies)
        
        numPiesLabel.text = "\(numPies)"
        
        levelNumber = getCurrentLevel()
        if (getIsOnFirstGame()){
            levelNumLabel.text = "\(levelNumber)"
            if (levelNumber < 3){
                ontoNextLevelLabel.text = "Onto Level \(levelNumber + 1)"
            }
            else{
                ontoNextLevelLabel.text = "Enough Play. Let's Get Real."
            }
        }
        else{
           levelNumLabel.text = "\(motionLevelNumber)"
            if (motionLevelNumber < 3){
                ontoNextLevelLabel.text = "Onto Level \(motionLevelNumber + 1)"
            }
            else{
                ontoNextLevelLabel.text = "See how much you baked in?"
            }
        }
        
        
        
        levelLabel.fontName = "BadaBoomBB"
        levelNumLabel.fontName = "BadaBoomBB"
        youMadeLabel.fontName = "HoboStd"
        
        pulsateNextLevelLabel = SKAction.repeatForever(SKAction.sequence([SKAction.run {
            self.ontoNextLevelLabel.color = UIColor.orange
            }, SKAction.wait(forDuration: 0.5), SKAction.run {
                self.ontoNextLevelLabel.color = UIColor.white
            }]))
        
        self.run(pulsateNextLevelLabel)
            
            
        
    }
    
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if (name == "ontoNextLevel"){
                if (getIsOnFirstGame()){
                    if (levelNumber < 3){
                        setCurrentLevel(level: (levelNumber+1))
                        addToTotNumPies(pies: numPies)
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.view?.presentScene(TrainingScene(fileNamed: "Training") as! TrainingScene as! SKScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 1.0))
                    }
                    else{
                        setIsOnFirstGame(bool: false)
                        let secondVC = PhaseTwoViewController()
                        
                        let navController = UINavigationController(rootViewController: secondVC)
                        
                        let newFrame = CGRect(x: navController.view.frame.origin.x, y: navController.view.frame.origin.y, width: 480.0, height: 640.0)
                        navController.view.frame = newFrame
                        
                        print(navController.view.frame.height)
                        print(navController.view.frame.width)
                        
                        secondVC.navigationController?.isNavigationBarHidden = true
                        secondVC.navigationController?.isToolbarHidden = true
                        
                        
                        PlaygroundPage.current.liveView = navController
                    }
                }
                else{
                    if (motionLevelNumber < 3){
                        setCurrentLevel(level: (levelNumber+1))
                        addToTotNumPies(pies: numPies)
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.view?.presentScene(PhaseTwoScene(fileNamed: "PhaseTwo") as! PhaseTwoScene as! SKScene, transition: SKTransition.doorsOpenHorizontal(withDuration: 1.0))
                    }
                    else{
                        self.removeAllActions()
                        self.removeAllChildren()
                        self.view?.presentScene(TotalEarningsScene(fileNamed: "TotalEarnings") as! TotalEarningsScene as! SKScene, transition: SKTransition.fade(withDuration: 1.0))
                    }
                }
                //self.present(PhaseTwoViewController(), animated: true, completion: nil)
                
            }
        }
    }
    

}
