//
//  TrainingScene.swift
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

public class TrainingScene: SKScene {
    
    var title:SKLabelNode!
    
    var trainingEye:SKSpriteNode!

    let closedEyeTexture = SKTexture(imageNamed: "closedEye")
    let straightEyeTexture = SKTexture(imageNamed: "openStraightEye")
    let upEyeTexture = SKTexture(imageNamed: "openUpEye")
    let downEyeTexture = SKTexture(imageNamed: "openDownEye")
    let rightEyeTexture = SKTexture(imageNamed: "openRightEye")
    let leftEyeTexture = SKTexture(imageNamed: "openLeftEye")
    
    var pie:SKLabelNode!
    var upApple:SKLabelNode!
    var downApple:SKLabelNode!
    var rightApple:SKLabelNode!
    var leftApple:SKLabelNode!
    
    var isUpApple = false
    var isDownApple = false
    var isRightApple = false
    var isLeftApple = false
    
    var countdownLabel: SKLabelNode!
    var timeLeft = 15
    
    var decrementTime:SKAction!
    var countdown:SKAction!
    
    var moveEyeDirContinuously:SKAction!
    
    var briefBlinkWait:SKAction!
    
    var pulsePieUp:SKAction!
    var pulsePieDown:SKAction!
    
    var numOfPiesLabel:SKLabelNode!
    var numOfPies = 0
    
    var levelNumber = 3.0
    
    var alreadyMadeMove = false
    
    
    
    public override func didMove(to view: SKView) {
        levelNumber = Double(getCurrentLevel())
        
        let titleFontURL = Bundle.main.url(forResource: "TacoModern", withExtension: "TTF")! as CFURL
        CTFontManagerRegisterFontsForURL(titleFontURL, CTFontManagerScope.process, nil)
        
        title = childNode(withName: "title") as? SKLabelNode
        title.fontName = "TacoModern"
        
        trainingEye = childNode(withName: "trainingEye") as? SKSpriteNode
        //trainingEye.run(trainingEyeResize)
        
        pie = childNode(withName: "pie") as? SKLabelNode
        numOfPiesLabel = childNode(withName: "numOfPies") as? SKLabelNode
        upApple = childNode(withName: "upApple") as? SKLabelNode
        downApple = childNode(withName: "downApple") as? SKLabelNode
        rightApple = childNode(withName: "rightApple") as? SKLabelNode
        leftApple = childNode(withName: "leftApple") as? SKLabelNode
        
        
        let countdownFontURL = Bundle.main.url(forResource: "StarcraftNormal", withExtension: "ttf")! as CFURL
        CTFontManagerRegisterFontsForURL(countdownFontURL, CTFontManagerScope.process, nil)
        countdownLabel = childNode(withName: "timeLeftNode") as? SKLabelNode
        countdownLabel.fontName = "StarcraftNormal"
        
        
        upApple.name = "up"
        downApple.name = "down"
        rightApple.name = "right"
        leftApple.name = "left"
                
        print("hello")
        changeEyeDirectionRandomly()
        
        decrementTime = SKAction.sequence([SKAction.wait(forDuration: 1.0), SKAction.run{self.countdownOneSecond()}])
        
        countdown = SKAction.repeat(decrementTime, count: 16)
        
        moveEyeDirContinuously = SKAction.repeatForever(SKAction.sequence([SKAction.run{self.changeEyeDirectionRandomly()}, SKAction.wait(forDuration: 1.0/levelNumber), SKAction.run {
            self.alreadyMadeMove = false
            }]))
        
        briefBlinkWait = SKAction.wait(forDuration: 0.2)
        
        pulsePieUp = SKAction.sequence([SKAction.run {
            self.pie.fontSize = 72.0
            }, SKAction.wait(forDuration: 0.2), SKAction.run {
                self.pie.fontSize = 64.0
            }])
        pulsePieDown = SKAction.sequence([SKAction.run {
            self.pie.fontSize = 48.0
            }, SKAction.wait(forDuration: 0.2), SKAction.run {
                self.pie.fontSize = 64.0
            }])
        
        self.run(countdown)
        self.run(moveEyeDirContinuously)
        self.run(SKAction.playSoundFileNamed("trainingSceneBackground.mp3", waitForCompletion: false))
        
        numOfPiesLabel.text = "\(numOfPies)"
        
        
    }
    
    
    func flashGreenApple(label: SKLabelNode){
        label.text = "🍏"
    }
    
    func flashBurnedApple(label: SKLabelNode){
        label.text = "🔥"
    }
    
    func restoreRedApple(label:SKLabelNode){
        label.text = "🍎"
    }
    
    

    func countdownOneSecond(){
        if (timeLeft > 0){
            timeLeft -= 1
            countdownLabel.text = "\(timeLeft)"
        }
        else{
            print("game over")
            print(numOfPies)
            setLastNumOfPies(num: numOfPies)
            print(getLastNumOfPies())
            self.view?.presentScene(LevelUpScene(fileNamed: "LevelUp")!, transition: SKTransition.doorsCloseHorizontal(withDuration: 1.0))
        }
    }
    
    func changeEyeDirectionRandomly(){
        let directionTextures = [upEyeTexture, downEyeTexture, rightEyeTexture, leftEyeTexture]
        let index = Int(arc4random_uniform(UInt32(directionTextures.count)))
        
        switch index{
        case 0:
            isUpApple = true
            isDownApple = false
            isRightApple = false
            isLeftApple = false
            
        case 1:
            isUpApple = false
            isDownApple = true
            isRightApple = false
            isLeftApple = false
            
        case 2:
            isUpApple = false
            isDownApple = false
            isRightApple = true
            isLeftApple = false
        
        case 3:
            isUpApple = false
            isDownApple = false
            isRightApple = false
            isLeftApple = true
        
        default:
            isUpApple = false
            isDownApple = false
            isRightApple = false
            isLeftApple = false
        }
        trainingEye.texture = directionTextures[index]
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        let touch:UITouch = touches.first!
        let positionInScene = touch.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name
        {
            switch name{
            case "up":
                if isUpApple{
                    print("yeet")
                    if (!self.alreadyMadeMove){
                        self.run(SKAction.sequence([SKAction.run{self.flashGreenApple(label: self.upApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.upApple)}]))
                        self.run(pulsePieUp)
                        self.numOfPies += 1
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.run(SKAction.playSoundFileNamed("dingSE.mp3", waitForCompletion: false))
                        self.alreadyMadeMove = true
                    }
                    
                    
                }
                else{
                    print("rip")
                    if (!self.alreadyMadeMove){
                        self.run(SKAction.sequence([SKAction.run{self.flashBurnedApple(label: self.upApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.upApple)}]))
                        self.run(pulsePieDown)
                        if (numOfPies > 0){
                            self.numOfPies -= 1
                        }
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.run(SKAction.playSoundFileNamed("loseSE.mp3", waitForCompletion: false))
                        self.alreadyMadeMove = true
                    }

                    
                }
            case "down":
                if isDownApple{
                    print("yeet")
                    if (!self.alreadyMadeMove){
                        self.run(SKAction.sequence([SKAction.run{self.flashGreenApple(label: self.downApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.downApple)}]))
                        self.run(pulsePieUp)
                        self.numOfPies += 1
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.alreadyMadeMove = true
                        self.run(SKAction.playSoundFileNamed("dingSE.mp3", waitForCompletion: false))
                    }


                }
                else{
                    print("rip")
                    if (!self.alreadyMadeMove){
                        self.run(SKAction.sequence([SKAction.run{self.flashBurnedApple(label: self.downApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.downApple)}]))
                        self.run(pulsePieDown)
                        if (numOfPies > 0){
                            self.numOfPies -= 1
                        }
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.run(SKAction.playSoundFileNamed("loseSE.mp3", waitForCompletion: false))
                        self.alreadyMadeMove = true
                    }

                }
            case "right":
                if isRightApple{
                    if (!self.alreadyMadeMove){
                        print("yeet")
                        self.run(SKAction.sequence([SKAction.run{self.flashGreenApple(label: self.rightApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.rightApple)}]))
                        self.run(pulsePieUp)
                        self.numOfPies += 1
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.alreadyMadeMove = true
                        self.run(SKAction.playSoundFileNamed("dingSE.mp3", waitForCompletion: false))
                    }



                }
                else{
                    print("rip")
                    if (!self.alreadyMadeMove){
                        self.run(SKAction.sequence([SKAction.run{self.flashBurnedApple(label: self.rightApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.rightApple)}]))
                        self.run(pulsePieDown)
                        if (numOfPies > 0){
                            self.numOfPies -= 1
                        }
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.run(SKAction.playSoundFileNamed("loseSE.mp3", waitForCompletion: false))
                        self.alreadyMadeMove = true
                    }

                    
                    }
            case "left":
                if isLeftApple{
                    print("yeet")
                    if (!alreadyMadeMove){
                        self.run(SKAction.sequence([SKAction.run{self.flashGreenApple(label: self.leftApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.leftApple)}]))
                        self.run(pulsePieUp)
                        self.numOfPies += 1
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.alreadyMadeMove = true
                        self.run(SKAction.playSoundFileNamed("dingSE.mp3", waitForCompletion: false))
                    }



                }
                else{
                    print("rip")
                    if (!alreadyMadeMove){
                        self.run(SKAction.sequence([SKAction.run{self.flashBurnedApple(label: self.leftApple)}, briefBlinkWait, SKAction.run {self.restoreRedApple(label: self.leftApple)}]))
                        self.run(pulsePieDown)
                        if (numOfPies > 0){
                            self.numOfPies -= 1
                        }
                        self.numOfPiesLabel.text = "\(numOfPies)"
                        self.run(SKAction.playSoundFileNamed("loseSE.mp3", waitForCompletion: false))
                        self.alreadyMadeMove = true
                    }

                }
                
            default:
                print("this shouldn't happen")
                //upApple.text = "🍏"
            }
            
        }
        
    }
    
   

}
