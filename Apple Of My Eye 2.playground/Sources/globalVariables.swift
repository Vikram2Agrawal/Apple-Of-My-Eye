//
//  globalVariables.swift
//  Apple Of My Eye
//
//  Created by Vikram Agrawal on 3/23/19.
//  Copyright © 2019 Vikram Agrawal. All rights reserved.
//

import Foundation

var currentLevel = 1
var motionCurrentLevel = 1
var lastNumOfPies = 0
var totalNumOfPies = 0
var isOnFirstGame = true

func addToTotNumPies(pies: Int){
    totalNumOfPies += pies
}

func getTotNumPies() -> Int{
    return totalNumOfPies
}

func setIsOnFirstGame(bool: Bool){
    isOnFirstGame = bool
}

func getIsOnFirstGame() -> Bool{
    return isOnFirstGame
}

func setMotionCurrentLevel(level: Int){
    motionCurrentLevel = level
}

func getMotionCurrentLevel() -> Int{
    return motionCurrentLevel
}

func getCurrentLevel() -> Int{
    return currentLevel
}

func setCurrentLevel(level: Int){
    currentLevel = level
}

func getLastNumOfPies() -> Int{
    return lastNumOfPies
}

func setLastNumOfPies(num: Int){
    lastNumOfPies = num
}

