/*:

# The Apple of My Eye
 ## Basic Rules
 The goal of the game is to follow the direction of the eye to make as many apple pies as you can!
 
 
 
 ## Game 1
 The first kind of game you'll encounter is a simple one where you must tap the apple the eye is looking at in order to make a pie. Be careful though! Tap the wrong apple and you burn a pie!
 
 
 
 ## Game 2
 The second game uses ARKit and CoreMotion technologies to put your apple pie making shindig in the real world, while giving you a great workout!
 
 In the 60 second marathon, forcefully move the device in the direction the eye is pointing to grab that apple and make an apple pie.
 
 Again, be careful not to go for the wrong apple or you'll burn a pie!
 
 VERY IMPORTANT FOR GAME 2: Make sure to hold your iPad in landscape mode, with the front facing camera on the left side - it's important for the accelerometer.

 */



import Foundation
import PlaygroundSupport
import SpriteKit
import UIKit
import ARKit



let initVC = PhaseOneViewController()

let navController = UINavigationController(rootViewController: initVC)

let newFrame = CGRect(x: navController.view.frame.origin.x, y: navController.view.frame.origin.y, width: 480.0, height: 640.0)
navController.view.frame = newFrame

print(navController.view.frame.height)
print(navController.view.frame.width)

initVC.navigationController?.isNavigationBarHidden = true
initVC.navigationController?.isToolbarHidden = true


PlaygroundPage.current.liveView = navController
PlaygroundPage.current.needsIndefiniteExecution = true

