//
//  GameViewController.swift
//  pathFinder
//
//  Created by Allan Wallace on 31/07/2016.
//  Copyright (c) 2016 Allan Wallace. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit
import SpriteKit
import GameKit
import AVFoundation
import Firebase
import GoogleMobileAds

struct bodyNames {
    static let Person = 0x1 << 1
    static let Coin = 0x1 << 2
    //static let bonus1 = 0x1 << 4
    
}



class GameViewController: UIViewController, SCNSceneRendererDelegate, SCNPhysicsContactDelegate, GKGameCenterControllerDelegate {
    
    let scene = SCNScene()
    let cameraNode = SCNNode()
    var person = SCNNode()
    let firstBox = SCNNode()
    var goingLeft = Bool()
    var tempBox = SCNNode()
    var prevBoxNumber = Int()
    var boxNumber = Int()
    var firstOne = Bool()
    var score = Int()
    var highscore = Int()
    var speed = Int()
    var counter = Int()
    var coinSound = AVAudioPlayer()
    var dead = Bool()
    var scoreLabel = UILabel()
    var highscoreLabel = UILabel()
    var livesLbl = UILabel()
    var gameOverLabel = UILabel()
    var HSTable = UILabel()
    var lives = 3
    var gameButton = UIButton()
    var newGameButton = UIButton()
    var personColor = UIColor()
    var red = CGFloat()
    var green = CGFloat()
    var blue = CGFloat()
    var boxMaterial = SCNMaterial()
    var gameOver = Bool()
    var highScore2 = Int()
    var highScore3 = Int()
    var highScore4 = Int()
    var highScore5 = Int()
    var highScore6 = Int()
    var temp = 0
    var temp2 = Int()
    var colourScheme = String()
    var startingSpeed = Int()
    var colourSchemeColour = UIColor()
    var kidsModeOn = String()
    var adView: GADBannerView!
    var newHighScore = Bool()
    
    
    
    override func viewDidLoad() {
        
        
        loadUserData()
        authenticatePlayer()
        baseColourScheme()
        setupGameScreenLabelsAndButtons()
        self.createNewScene()
        scene.physicsWorld.contactDelegate = self
        
    }
 
  
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
       
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        if nodeA.physicsBody?.categoryBitMask == bodyNames.Coin && nodeB.physicsBody?.categoryBitMask == bodyNames.Person{
            
            
            nodeA.removeFromParentNode()
            addScore()
           // coinSound.play()
            
            
                
            

        }
            
            
            
        else if nodeA.physicsBody?.categoryBitMask == bodyNames.Person && nodeB.physicsBody?.categoryBitMask == bodyNames.Coin{
            
            
            nodeB.removeFromParentNode()
            addScore()
            //coinSound.play()
            
        }
        
     
           
    }

    func Action(_ sender: UIButton!){
        self.performSegue(withIdentifier: "newsegue", sender: nil)
        
    }
    
    
    func updateLabel(){
         if gameOver == true{
            scoreLabel.isHidden = true
            highscoreLabel.isHidden = true
            livesLbl.isHidden = true
            newGameButton.isHidden = false
            adView.isHidden = false
            
        } else {
            gameOverLabel.isHidden = true
            scoreLabel.text = "Score : \(score)"
            highscoreLabel.text = "Highscore : \(highscore)"
            livesLbl.text = "Lives : \(lives)"
            if dead == true {
                adView.isHidden = false
            }

        }
        
        
        
        
    }
    
    
    func addScore(){
        score += 1
        
        self.performSelector(onMainThread: #selector(GameViewController.updateLabel), with: nil, waitUntilDone: false)

        
        
        if score > highscore{
            
            highscore = score
            
            let scoreDefault = UserDefaults.standard
            scoreDefault.set(highscore, forKey: "highscore")
            
            
        }
        
    }
    
    func loadUserData(){
        let savedStartSpeed = UserDefaults.standard
        let savedColourScheme = UserDefaults.standard
        let kidsMode = UserDefaults.standard
        
        if savedStartSpeed.integer(forKey: "startingSpeed") == 0 {
            startingSpeed = -60
        } else {
            startingSpeed = savedStartSpeed.integer(forKey: "startingSpeed")
        }
        
        if savedColourScheme.string(forKey: "chosenColourScheme") == nil {
            colourScheme = "blue"
        } else {
            
        colourScheme = savedColourScheme.string(forKey: "chosenColourScheme")!
            
        
    }
        if kidsMode.string(forKey: "kidsMode") == nil {
            kidsModeOn = "off"
        } else {
            kidsModeOn = kidsMode.string(forKey: "kidsMode")!
            
        }
        
        
    }
    
    func baseColourScheme(){
        
        if colourScheme == "pink" {
            colourSchemeColour = UIColor(red: 0.9137, green: 0.1176, blue: 0.3882, alpha: 1.0 )
            personColor = UIColor(red: 0.5647, green: 0.7921, blue: 0.9765, alpha: 1.0)
        } else if colourScheme == "blue" {
            colourSchemeColour = UIColor(red: 0.3764, green: 0.4902, blue: 0.5451, alpha: 1.0 )
            personColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )

        } else if colourScheme == "random" {
            colourSchemeColour = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )
            personColor = UIColor(red: 1.0, green: 0.502, blue: 0.5, alpha: 1.0 )
        }
        
    }
    
    func setupGameScreenLabelsAndButtons () {
        let request = GADRequest()
        adView = GADBannerView(frame: CGRect(origin: CGPoint(x: (self.view.frame.width / 2) - 160, y: self.view.frame.height / 2 + (self.view.frame.height / 2) - 50), size: CGSize(width: 320, height: 50)))
        
        if colourScheme == "blue" {
            
        
        // live add unitID
        adView.adUnitID = "ca-app-pub-6474009264275372/5132767841"
        } else if colourScheme == "pink" {
            
        //pink add UnitID
            //adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adView.adUnitID = "ca-app-pub-6474009264275372/5940019843"
        } else if colourScheme == "random" {
        
        //Random add UniID
            //adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        adView.adUnitID = "ca-app-pub-6474009264275372/7416753049"
            
        }
        //test add unitID
        //adView.adUnitID = "ca-app-pub-3940256099942544/2934735716"

        
        adView.rootViewController = self
        
        if kidsModeOn == "on" {
        request.tag(forChildDirectedTreatment: true)
        } else  { request.tag(forChildDirectedTreatment: false)
        }
        adView.load(request)
        self.view.addSubview(adView)
        
        
        
        scoreLabel = UILabel(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + self.view.frame.height / 2.5), size: CGSize(width: self.view.frame.width, height: 100)))
        
        scoreLabel.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 - self.view.frame.height / 2.5)
        scoreLabel.textAlignment = .center
        scoreLabel.text = "Score : \(score)"
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 22)
        scoreLabel.textColor = UIColor.darkGray
        self.view.addSubview(scoreLabel)
        
        livesLbl = UILabel(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + self.view.frame.height / 2.7), size: CGSize(width: self.view.frame.width, height: 100)))
        
        livesLbl.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 - self.view.frame.height / 2.7)
        livesLbl.textAlignment = .center
        livesLbl.text = "Lives : \(lives)"
        livesLbl.textColor = UIColor.darkGray
        self.view.addSubview(livesLbl)
        
        
        highscoreLabel = UILabel(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + self.view.frame.height / 2.8), size: CGSize(width: self.view.frame.width, height: 100)))
        
        highscoreLabel.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + self.view.frame.height / 2.8)
        highscoreLabel.textAlignment = .center
        highscoreLabel.textColor = UIColor.darkGray
        highscoreLabel.font = UIFont.systemFont(ofSize: 22)
        self.view.addSubview(highscoreLabel)
        
        
        newGameButton = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2, y: (self.view.frame.height / 2) - 200), size: CGSize(width: self.view.frame.width - 100, height: 100)))
        
        
        newGameButton.backgroundColor = colourSchemeColour
        newGameButton.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2)
        newGameButton.layer.cornerRadius = 8.0
        newGameButton.layer.shadowRadius = 6.0
        newGameButton.layer.shadowOpacity = 0.8
        
        newGameButton.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        newGameButton.setTitle("Game Over", for: .normal)
        newGameButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 35)
        newGameButton.addTarget(self, action: #selector(GameViewController.Action(_:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(newGameButton)
        newGameButton.isHidden = true
        
        
        gameButton = UIButton(type: UIButtonType.custom)
        gameButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        gameButton.center = CGPoint(x: self.view.frame.width - 40, y: 60)
        gameButton.setImage(UIImage(named: "gamebutton"), for: UIControlState())
        gameButton.addTarget(self, action: #selector(GameViewController.showLeaderboard), for: UIControlEvents.touchUpInside)
        self.view.addSubview(gameButton)
    }

    
    func fadeIn(_ node : SCNNode){
        
        node.opacity = 0
        node.runAction(SCNAction.fadeIn(duration: 0.5))
        
    }
    
    
    func createCoin(_ box : SCNNode){
        scene.physicsWorld.gravity = SCNVector3Make(0, 0, 0)
        let spin = SCNAction.rotate(by: CGFloat(M_PI * 2), around: SCNVector3Make(0, 0.5 , 0) , duration: 0.75)
        var coinFreq = UInt32()
        if startingSpeed == -60 {
            coinFreq = 7
        } else if startingSpeed == -80 {
            coinFreq = 5
        } else if startingSpeed == -110 {
            coinFreq = 3
        }
        
        let randomNumber = arc4random() % coinFreq
        if randomNumber == 2{
            let coinScene = SCNScene(named: "Coin.dae")
            let coin = coinScene?.rootNode.childNode(withName: "Coin", recursively: true)
            coin?.position = SCNVector3Make(box.position.x, box.position.y + 1, box.position.z)
            coin?.scale = SCNVector3Make(0.2, 0.2, 0.2)
            
            
            coin?.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.dynamic, shape: SCNPhysicsShape(node: coin!, options: nil))
            coin?.physicsBody?.categoryBitMask = bodyNames.Coin
            coin?.physicsBody?.contactTestBitMask = bodyNames.Person
            coin?.physicsBody?.collisionBitMask = bodyNames.Person
            coin?.physicsBody?.isAffectedByGravity = false
            
            
            scene.rootNode.addChildNode(coin!)
            coin?.runAction(SCNAction.repeatForever(spin))
        
            fadeIn(coin!)
            
            
            
        }
        
    }
    
    func fadeOutx(_ node : SCNNode){
        
        
        let move = SCNAction.move(to: SCNVector3Make(node.position.x + 5, node.position.y, node.position.z), duration: 0.5)
        node.runAction(move)
        node.runAction(SCNAction.fadeOut(duration: 0.5))
        
        
        
    }
    
    
    func fadeOutz(_ node : SCNNode){
        
        
        let move = SCNAction.move(to: SCNVector3Make(node.position.x, node.position.y, node.position.z + 5), duration: 0.5)
        node.runAction(move)
        node.runAction(SCNAction.fadeOut(duration: 0.5))
    }
    
    
    
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if dead == false{
            let deleteBox = self.scene.rootNode.childNode(withName: "\(prevBoxNumber)", recursively: true)
            
            let currentBox = self.scene.rootNode.childNode(withName: "\(prevBoxNumber + 1)", recursively: true)
            
            if (deleteBox?.position.x)! > person.position.x + 1 {
                prevBoxNumber += 1
                fadeOutx(deleteBox!)
                createBox()
                
            } else if (deleteBox?.position.z)! > person.position.z + 1{
                prevBoxNumber += 1
                fadeOutz(deleteBox!)
                createBox()
                
            }
            
            if person.position.x > currentBox!.position.x - 0.55 && person.position.x < currentBox!.position.x + 0.55 || person.position.z > currentBox!.position.z - 0.55 && person.position.z < currentBox!.position.z + 0.55 {
              dead = false
                
                
            }
            else{
                dead = true
                die()
                
            }
            
        }
        
    }
    
    func die(){
        person.runAction(SCNAction.move(to: SCNVector3Make(person.position.x, person.position.y - 10, person.position.z), duration: 1.0))
        
        let wait = SCNAction.wait(duration: 0.75)
        loseLife()
    
        
        
       if lives != 0{
        
        let sequence = SCNAction.sequence([wait, SCNAction.run({
            node in
            
            self.scene.rootNode.enumerateChildNodes({
                node, stop in
                
                node.removeFromParentNode()
                
            })
            
        }), SCNAction.run({
            node in
            
            self.createScene()
            
            
        })])
        
        
    
    
        person.runAction(sequence)
       }  else {
        gameOver = true
        gameOverFunc()
        
        
        }
    }
    
    func loseLife(){
        lives -= 1
        self.performSelector(onMainThread: #selector(GameViewController.updateLabel), with: nil, waitUntilDone: false)
    }
    
        func updatedScores(){
            let savedHighScore2 = UserDefaults.standard
            let savedHighScore3 = UserDefaults.standard
            let savedHighScore4 = UserDefaults.standard
            let savedHighScore5 = UserDefaults.standard
            let savedHighScore6 = UserDefaults.standard
            let finalScore = UserDefaults.standard
            
            
            if savedHighScore2.integer(forKey: "savedHighScore2") != 0{
                
                highScore2 = savedHighScore2.integer(forKey: "savedHighScore2")
            } else {
                highScore2 = 0
            }
            
            if savedHighScore3.integer(forKey: "savedHighScore3") != 0{
                
                highScore3 = savedHighScore3.integer(forKey: "savedHighScore3")
            } else {
                highScore3 = 0
            }
            
            
            if savedHighScore4.integer(forKey: "savedHighScore4") != 0{
                
                highScore4 = savedHighScore4.integer(forKey: "savedHighScore4")
            } else {
                highScore4 = 0
            }
            
            
            if savedHighScore5.integer(forKey: "savedHighScore5") != 0{
                
                highScore5 = savedHighScore5.integer(forKey: "savedHighScore5")
            } else {
                highScore5 = 0
            }
            
            if savedHighScore6.integer(forKey: "savedHighScore6") != 0{
                
                highScore6 = savedHighScore6.integer(forKey: "savedHighScore6")
            } else {
                highScore6 = 0
            }
            
            
            if score > highScore6 {
                
                highScore6 = score
                
            }
            if  highScore6 > highScore5 {
                temp = highScore5
                highScore5 = highScore6
                highScore6 = temp
                temp = 0
            }
            
            if  highScore5 > highScore4 {
                temp = highScore4
                highScore4 = highScore5
                highScore5 = temp
                temp = 0
                
                
            }
            
            if  highScore4 > highScore3 {
                temp = highScore3
                highScore3 = highScore4
                highScore4 = temp
                temp = 0
                
            }
            
            if  highScore3 > highScore2 {
                temp = highScore2
                highScore2 = highScore3
                highScore3 = temp
                temp = 0
                
            }
            if  highScore2 > highscore {
                temp = highscore
                highscore = highScore2
                highScore2 = temp
                temp = 0
                newHighScore = true
                
            }
            
            savedHighScore2.set(highScore2, forKey: "savedHighScore2")
            savedHighScore3.set(highScore3, forKey: "savedHighScore3")
            savedHighScore4.set(highScore4, forKey: "savedHighScore4")
            savedHighScore5.set(highScore5, forKey: "savedHighScore5")
            savedHighScore6.set(highScore6, forKey: "savedHighScore6")
            finalScore.set(score, forKey: "finalScore")
        }
        

    
    func gameOverFunc(){
        
     updatedScores()
        let wait = SCNAction.wait(duration: 0.75)
        let sequence = SCNAction.sequence([wait, SCNAction.run({
            node in
            
            self.scene.rootNode.enumerateChildNodes({
                node, stop in
                
                node.removeFromParentNode()
                
            })
            
            
            
        }), SCNAction.run({
            node in
            
            
            self.person.isHidden = true
            
            
            self.performSelector(onMainThread: #selector(GameViewController.updateLabel), with: nil, waitUntilDone: false)
        
            
        })])
        
        
        
        
        person.runAction(sequence)
    }
    
    
    

    
    
    func createBox(){
        tempBox = SCNNode(geometry: firstBox.geometry)
        let prevBox = scene.rootNode.childNode(withName: "\(boxNumber)", recursively: true)
        boxNumber += 1
        tempBox.name = "\(boxNumber)"
        counter += 1
        if counter == 25 {
            speed -= 1
            addScore()
            counter = 0
        }
        
        let randomNumber = arc4random() % 2
        
        switch randomNumber{
            
        case 0:
            tempBox.position = SCNVector3Make((prevBox?.position.x)! - firstBox.scale.x, (prevBox?.position.y)!, (prevBox?.position.z)!)
            if firstOne == true{
                firstOne = false
                goingLeft = false
            }
            break
        case 1:
            tempBox.position = SCNVector3Make((prevBox?.position.x)!, (prevBox?.position.y)!, (prevBox?.position.z)! - firstBox.scale.z)
            if firstOne == true{
                firstOne = false
                goingLeft = true
            }
            break
        default:
            
            break
        }
        self.scene.rootNode.addChildNode(tempBox)
        createCoin(tempBox)
        fadeIn(tempBox)
       // playSound()
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        if dead == false{
            self.performSelector(onMainThread: #selector(GameViewController.updateLabel), with: nil, waitUntilDone: false)
            if goingLeft == false{
                person.removeAllActions()
                person.runAction(SCNAction.repeatForever(SCNAction.move(by: SCNVector3Make(Float(speed), 0, 0), duration: 20)))
                goingLeft = true
                adView.isHidden = true
                
            }
            else {
                person.removeAllActions()
                person.runAction(SCNAction.repeatForever(SCNAction.move(by: SCNVector3Make(0, 0, Float(speed)), duration: 20)))
                goingLeft = false
                adView.isHidden = true
            }
        }
    }
    
    
    
    func newBox(){
        
        if colourScheme == "random" {
        
        red = CGFloat((arc4random()%10)+2)/12
        
        green = CGFloat((arc4random()%10)+2)/12
        blue = CGFloat((arc4random()%10)+2)/12
        boxMaterial.diffuse.contents = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            
        } else {
            boxMaterial.diffuse.contents = colourSchemeColour
            
        }
        }
    
    func createNewScene(){
        newBox()
        updateLabel()
        let scoreDefault = UserDefaults.standard
        if scoreDefault.integer(forKey: "highscore") != 0{
            
            highscore = scoreDefault.integer(forKey: "highscore")
        }
        else{
            
            highscore = 0
        }
        gameOver = false
        lives = 3
        boxNumber = 0
        score = 0
        prevBoxNumber = 0
        firstOne = true
        dead = false
        newHighScore = false
        
        if kidsModeOn == "off"{
            
        speed = startingSpeed
        } else { speed = startingSpeed / 2
        }
        counter = 0

        self.view.backgroundColor = .white
        let sceneView = self.view as! SCNView
        sceneView.delegate = self
        sceneView.scene = scene
        
        setup()
    }
    
    
    
    func createScene(){
        newBox()
        updateLabel()
        boxNumber = 0
        prevBoxNumber = 0         
        firstOne = true
        dead = false
        speed += 2
        counter = 0
        
        
        self.view.backgroundColor = .white
        let sceneView = self.view as! SCNView
        sceneView.delegate = self
        sceneView.scene = scene

        setup()
    }
    
    
    
    func setup(){
        
        //Create Person
        
        
        let personGeo = SCNSphere(radius: 0.2)
        person = SCNNode(geometry: personGeo)
        let personMat = SCNMaterial()
        personMat.diffuse.contents = personColor
        personGeo.materials = [personMat]
        person.position = SCNVector3Make(0, 1.05, 0)
        
        person.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.static, shape:SCNPhysicsShape(node: person, options: nil))
        person.physicsBody?.categoryBitMask = bodyNames.Person
        person.physicsBody?.collisionBitMask = bodyNames.Coin
        person.physicsBody?.contactTestBitMask = bodyNames.Coin
        person.physicsBody?.isAffectedByGravity = false
        
        
        scene.rootNode.addChildNode(person)
        
        
        //Create Camera
        
        cameraNode.camera = SCNCamera()
        cameraNode.camera?.usesOrthographicProjection = true
        cameraNode.camera?.orthographicScale = 3
        cameraNode.position = SCNVector3Make(20, 20, 20)
        cameraNode.eulerAngles = SCNVector3Make(-45, 45, 0)
        let constraint = SCNLookAtConstraint(target: person)
        constraint.isGimbalLockEnabled = true
        self.cameraNode.constraints = [constraint]
        scene.rootNode.addChildNode(cameraNode)
        person.addChildNode(cameraNode)
        
        
        //Create Box
        newBox()
        let firstBoxGeo = SCNBox(width: 1, height: 1.5, length: 1, chamferRadius: 0.1)
        firstBox.geometry = firstBoxGeo
        firstBoxGeo.materials = [boxMaterial]
        firstBox.position = SCNVector3Make(0, 0, 0)
        scene.rootNode.addChildNode(firstBox)
        firstBox.name = "\(boxNumber)"
        firstBox.opacity = 1
        for _ in 0...6{
            createBox()
        }
        
        
        //Create Light
        
        let light = SCNNode()
        light.light = SCNLight()
        light.light?.type = SCNLight.LightType.directional
        light.eulerAngles = SCNVector3Make(-45, 45, 0)
        scene.rootNode.addChildNode(light)
        
        let light2 = SCNNode()
        light2.light = SCNLight()
        light2.light?.type = SCNLight.LightType.directional
        light2.eulerAngles = SCNVector3Make(45, -46, 0)
        scene.rootNode.addChildNode(light2)
        
    }
    
    
    func authenticatePlayer(){
     
     let localPlayer = GKLocalPlayer()
     
     localPlayer.authenticateHandler = {
     (viewController, error) in
     
     if viewController != nil {
     
     self.present(viewController!, animated: true, completion: nil)
     }
     
     else{
     
     }
     
     
     }
     
     
     }
     
     func saveHighscore(score : Int){
     
     if GKLocalPlayer.localPlayer().isAuthenticated {
        if newHighScore == true {
        
        if kidsModeOn == "off" {
     
     let scoreReporter = GKScore(leaderboardIdentifier: "BR001LB")
     
     scoreReporter.value = Int64(score)
     
     
     let scoreArray : [GKScore] = [scoreReporter]
     
     GKScore.report(scoreArray, withCompletionHandler: nil)
            
        } else if kidsModeOn == "on" {
            let scoreReporter = GKScore(leaderboardIdentifier: "BRKLB001")
            
            scoreReporter.value = Int64(score)
            
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: nil)
            
        }
    
     
        }
        newHighScore = false
     
        }
    }
    
     func showLeaderboard(){
     saveHighscore(score: highscore)
     
     let gc = GKGameCenterViewController()
     
     gc.gameCenterDelegate = self
     
     self.present(gc, animated: true, completion: nil)
     
     
     }
     
     func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
     gameCenterViewController.dismiss(animated: true, completion: nil)
     }
     
     
    //    func playSound() {
    //        let path = URL(fileURLWithPath: Bundle.main.path(forResource: "coin", ofType: "aiff")!)
    //
    //        do {
    //            try coinSound = AVAudioPlayer(contentsOf: path)
    //            coinSound.prepareToPlay()
    //
    //
    //
    //        } catch let err as NSError {
    //            print(err.debugDescription)
    //        }
    //
    //
    //
    //        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
    //        try! AVAudioSession.sharedInstance().setActive(true)
    //        
    //
    //    }
    //    
    
  
    
    
    
    
}
