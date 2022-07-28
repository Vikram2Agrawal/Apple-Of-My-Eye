//
//  IntroScene.swift
//  Apple Of My Eye
//
//  Created by Vikram Agrawal on 3/23/19.
//  Copyright © 2019 Vikram Agrawal. All rights reserved.
//

import Foundation
import PlaygroundSupport
import SpriteKit
import UIKit
import ARKit

public class IntroScene: SKScene {
    
    private var ofMyLabel : SKLabelNode!
    private var appleLogo: SKLabelNode!
    private var splashOpenEye: SKSpriteNode!
    private var audioPlayer: SKAudioNode!
    
    private var fadeInIntro = SKAction.fadeIn(withDuration: 3.0)
    private var pulsate = SKAction.sequence([.scale(to: 0.7, duration: 2.0), .scale(to: 1.0, duration: 2.0)])
    private var explode = SKAction.scale(to: 50.0, duration: 2.0)
    private var soundOut = SKAction.sequence([.changeVolume(to: 0.0, duration: 0.5), .wait(forDuration: 0.5)])
    
    
    
    
    
    public override func didMove(to view: SKView) {
        let fontURL = Bundle.main.url(forResource: "DimitriSwank", withExtension: "TTF")! as CFURL
        CTFontManagerRegisterFontsForURL(fontURL, CTFontManagerScope.process, nil)
        
        // Get label node from scene and store it for use later
        ofMyLabel = childNode(withName: "ofMy") as? SKLabelNode
        appleLogo = childNode(withName: "theApple") as? SKLabelNode
        splashOpenEye = childNode(withName: "splashOpenEye") as? SKSpriteNode
        audioPlayer = childNode(withName: "introBG") as? SKAudioNode
        
        ofMyLabel.alpha = 0
        appleLogo.alpha = 0
        splashOpenEye.alpha = 0
        
        ofMyLabel.run(fadeInIntro)
        appleLogo.run(fadeInIntro)
        splashOpenEye.run(fadeInIntro)
        
        splashOpenEye.run(.repeatForever(pulsate))
        splashOpenEye.name = "splashOpenEye"
        splashOpenEye.isUserInteractionEnabled = false
        
        ofMyLabel.fontName = "DimitriSwank"
        
        print("hello")
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print ("im touched")
        audioPlayer.run(soundOut)
        self.view?.presentScene(TrainingScene(fileNamed: "Training") as! TrainingScene, transition: SKTransition.doorsOpenVertical(withDuration: 1.5))
        
    }
    
    
    
}
