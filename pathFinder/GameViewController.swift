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
    static let Bonus = 0x1 << 4
    
}



class GameViewController: UIViewController, SCNSceneRendererDelegate, SCNPhysicsContactDelegate, GKGameCenterControllerDelegate {
    
    //Variables
    //Scene
    let scene = SCNScene()
    let cameraNode = SCNNode()
    var person = SCNNode()
    let firstBox = SCNNode()
    var goingLeft = Bool()
    var tempBox = SCNNode()
    var prevBoxNumber = Int()
    var boxNumber = Int()
    var firstOne = Bool()
    var boxMaterial = SCNMaterial()
    
    //Gameplay
    var score = Int()
    var highscore = Int()
    var speed = Int()
    var counter = Int()
    var boxCounter = Int()
    var coinSound = AVAudioPlayer()
    var bonusSound = AVAudioPlayer()
    var soundtrack = AVAudioPlayer()
    var dead = Bool()
    var lives = 2
    var gameOver = Bool()
    var highScore2 = Int()
    var highScore3 = Int()
    var highScore4 = Int()
    var highScore5 = Int()
    var highScore6 = Int()
    var bonusCounter = Int()
    
    //labels
    var scoreLabel = UILabel()
    var highscoreLabel = UILabel()
    var livesLbl = UILabel()
    var gameOverLabel = UILabel()
    var HSTable = UILabel()
    var bonusLbl = UILabel()
    var bonusMessage = ""
    
    
    //buttons
    var gameButton = UIButton()
    var newGameButton = UIButton()
    var personColor = UIColor()
    var red = CGFloat()
    var green = CGFloat()
    var blue = CGFloat()
    
    
    
    //setup
    var colourScheme = String()
    var startingSpeed = Int()
    var speedName = String()
    var mainColor = UIColor()
    var kidsModeOn = Bool()
    var currentBonus = String()
    var adView: GADBannerView!
    var soundOn = Bool()
    var musicOn = Bool()
    var personMat = SCNMaterial()
    var temp = 0
    
    
    
    override func viewDidLoad() {
        
        loadUserData()
        
        
        
        authenticatePlayer()
        
        baseColourScheme()
        
        setupGameScreenLabelsAndButtons()
        
        setSpeed()
        if soundOn == true {
            playSound()
           
        }
        
        if musicOn == true {
            playMusic()
        }
        print("KidsMode \(kidsModeOn)")
        
        self.createNewScene()
        scene.physicsWorld.contactDelegate = self
        
        
    }
    
    func loadUserData(){
        let savedStartSpeed = UserDefaults.standard
        let savedColourScheme = UserDefaults.standard
        let kidsMode = UserDefaults.standard
        let soundMode = UserDefaults.standard
        let musicMode = UserDefaults.standard
        var sound = Bool()
        var soundString = String()
        
        let speedcheck = UserDefaults.standard
        if speedcheck.string(forKey: "startingSpeed") == nil {
            speedcheck.set("Hyper-Active", forKey: "startingSpeed")
        }
        if speedcheck.string(forKey: "startingSpeed")! == "Slow" || speedcheck.string(forKey: "startingSpeed")! == "Hyper-Acive" || speedcheck.string(forKey: "startingSpeed")! == "Ludicrous" {
           
        } else {
            speedcheck.set("Hyper-Active", forKey: "startingSpeed")

        }
        if savedStartSpeed.string(forKey: "startingSpeed") != nil {
            speedName = savedStartSpeed.string(forKey: "startingSpeed")!
        } else {
            speedName = "Hyper-Active"
        }
        
        if savedColourScheme.string(forKey: "chosenColourScheme") == nil {
            colourScheme = "blue"
        } else {
            
        colourScheme = savedColourScheme.string(forKey: "chosenColourScheme")!
            
        
    }
        if kidsMode.bool(forKey: "kidsMode") == true || kidsMode.bool(forKey: "kidsMode") == false {
            kidsModeOn = kidsMode.bool(forKey: "kidsMode")
        } else {
            kidsMode.set(false, forKey: "kidsMode")
            kidsModeOn = kidsMode.bool(forKey: "kidsMode")
            
        }
        
        if soundMode.string(forKey: "soundMode") == nil {
            soundMode.set(true, forKey: "soundMode")
        }
        if soundMode.bool(forKey: "soundMode") == true || soundMode.bool(forKey: "soundMode") == false {
            sound = soundMode.bool(forKey: "soundMode")
            print ("....Sound.... \(sound) ..\(soundString)")
            soundOn = soundMode.bool(forKey: "soundMode")
        } else {
            soundMode.set(true, forKey: "soundMode")
            soundOn = soundMode.bool(forKey: "soundMode")
        }
        if soundMode.string(forKey: "musicMode") == nil {
            soundMode.set(true, forKey: "musicMode")
        }
        if musicMode.bool(forKey: "musicMode") == true || musicMode.bool(forKey: "musicMode") == false {
            musicOn = soundMode.bool(forKey: "musicMode")
            
        } else {
            musicMode.set(true, forKey: "musicMode")
            musicOn = musicMode.bool(forKey: "musicMode")
            
        }
        
        
    
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
            if kidsModeOn == false{
                
                let scoreReporter = GKScore(leaderboardIdentifier: "BR001LB")
                
                scoreReporter.value = Int64(score)
                
                
                let scoreArray : [GKScore] = [scoreReporter]
                
                GKScore.report(scoreArray, withCompletionHandler: nil)
                
            
                
            } else if kidsModeOn == true {
                let scoreReporter = GKScore(leaderboardIdentifier: "BRKLB001")
                
                scoreReporter.value = Int64(score)
                
                
                let scoreArray : [GKScore] = [scoreReporter]
                
                GKScore.report(scoreArray, withCompletionHandler: nil)
                
            }
            
            
            
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
    
    
    func baseColourScheme(){
        
        if colourScheme == "pink" {
            
            mainColor = PINK_COLOR

            personColor = UIColor(red: 0.5647, green: 0.7921, blue: 0.9765, alpha: 1.0)
        } else if colourScheme == "blue" {
            mainColor = BLUE_COLOR

            personColor = UIColor(red: 1.0, green: 0.502, blue: 0.051, alpha: 1.0 )

        } else if colourScheme == "random" {
            mainColor = RANDOM_COLOR
            personColor = UIColor(red: 1.0, green: 0.502, blue: 0.5, alpha: 1.0 )
        }
        
        print("main colour is \(mainColor)")

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
        
        if kidsModeOn == true {
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
        livesLbl.text = "Rides : \(lives)"
        livesLbl.textColor = UIColor.darkGray
        self.view.addSubview(livesLbl)
        
        
        highscoreLabel = UILabel(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + self.view.frame.height / 2.8), size: CGSize(width: self.view.frame.width, height: 100)))
        
        highscoreLabel.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + self.view.frame.height / 2.8)
        highscoreLabel.textAlignment = .center
        highscoreLabel.textColor = UIColor.darkGray
        highscoreLabel.font = UIFont.systemFont(ofSize: 22)
        self.view.addSubview(highscoreLabel)
        
        
        bonusLbl = UILabel(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 + self.view.frame.height / 3.2), size: CGSize(width: self.view.frame.width, height: 100)))
        
        bonusLbl.center = CGPoint(x: self.view.frame.width / 2, y: self.view.frame.height / 2 - self.view.frame.height / 3.2)

        bonusLbl.textAlignment = .center
        bonusLbl.textColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        bonusLbl.font = UIFont.systemFont(ofSize: 35)
       
        self.view.addSubview(bonusLbl)
       
        
        
        newGameButton = UIButton(frame: CGRect(origin: CGPoint(x: self.view.frame.width / 2, y: (self.view.frame.height / 2) - 200), size: CGSize(width: self.view.frame.width - 100, height: 100)))
        
       
        newGameButton.backgroundColor = mainColor
        
        
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

    func setup(){
        
        //Create Person
        
        
        let personGeo = SCNSphere(radius: 0.2)
        person = SCNNode(geometry: personGeo)
        
        personMat.diffuse.contents = personColor
        personGeo.materials = [personMat]
        person.position = SCNVector3Make(0, 1.05, 0)
        
        person.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.static, shape:SCNPhysicsShape(node: person, options: nil))
        person.physicsBody?.categoryBitMask = bodyNames.Person
        person.physicsBody?.collisionBitMask = bodyNames.Bonus
        person.physicsBody?.contactTestBitMask = bodyNames.Bonus
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
        let firstBoxGeo = SCNBox(width: 1.0, height: 1.5, length: 1.0, chamferRadius: 0.1)
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
    
    
    func setSpeed() {
        if speedName == "Slow" {
            startingSpeed = -60
        } else if speedName == "Hyper-Active" {
            startingSpeed = -85
        } else if speedName == "Ludicrous" {
            startingSpeed = -100
        }
        
    }
    
    
    func newBox(){
        
        if colourScheme == "random" {
            
            red = CGFloat((arc4random()%10)+2)/12
            
            green = CGFloat((arc4random()%10)+2)/12
            blue = CGFloat((arc4random()%10)+2)/12
            boxMaterial.diffuse.contents = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            
        } else {
            
            boxMaterial.diffuse.contents = mainColor
            
            
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
        lives = 2
        boxNumber = 0
        score = 0
        prevBoxNumber = 0
        firstOne = true
        dead = false
        boxCounter = 0
        bonusCounter = 0
        
        
        if kidsModeOn == false {
            
            speed = startingSpeed
        } else { speed = startingSpeed / 2
        }
        counter = -10
        
        
        if musicOn == true {
            soundtrack.prepareToPlay()
            soundtrack.play()
            soundtrack.numberOfLoops = -1

        
        }
        
        self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
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
        counter = -10
        bonusCounter = 0
        currentBonus = ""
        
        if musicOn == true {
            soundtrack.prepareToPlay()
            soundtrack.play()
            soundtrack.numberOfLoops = -1
        }

        
        
        
        self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
        let sceneView = self.view as! SCNView
        sceneView.delegate = self
        sceneView.scene = scene
        
        setup()
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
            
            if person.position.x > currentBox!.position.x - 0.52 && person.position.x < currentBox!.position.x + 0.52 || person.position.z > currentBox!.position.z - 0.52 && person.position.z < currentBox!.position.z + 0.52 {
                
                
                
            }
            else{
                dead = true
                person.runAction(SCNAction.move(to: SCNVector3Make(person.position.x, person.position.y - 10, person.position.z), duration: 1.0))
                die()
                
                
            }
            
        }
        
        
    }
    
    

    func createBox(){
        
        
        tempBox = SCNNode(geometry: firstBox.geometry)
        let prevBox = scene.rootNode.childNode(withName: "\(boxNumber)", recursively: true)
        boxNumber += 1
        tempBox.name = "\(boxNumber)"
        counter += 1
        boxCounter += 1
        bonusCounter += 1
        
        
        if speedName == "Ludicrous" && counter <= 25 && counter >= 1 && counter % 2 == 0{
            addScore()
        } else if speedName == "Hyper-Active" && counter <= 25 && counter >= 1 && counter % 3 == 0{
            addScore()
        } else if speedName == "Slow" && counter <= 25 && counter >= 1 && counter % 5 == 0 {
            addScore()
        }
        if counter == 25 {
            speed -= 1
            addScore()
            counter = 0
        }
        
        if bonusCounter >= 5  && currentBonus != "FreeRide" {
            self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            addScore()
          
        } else if bonusCounter >= 50 {
            self.view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0)
            currentBonus = ""
            bonusCounter = 0
            addScore()
        }
        
        
        
        if currentBonus != "FreeRide" {
        
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
        } else {
            
            tempBox.position = SCNVector3Make((prevBox?.position.x)! - firstBox.scale.x, (prevBox?.position.y)!, (prevBox?.position.z)!)
            if firstOne == true{
                firstOne = false
                goingLeft = false
               

            
        }
        }
        self.scene.rootNode.addChildNode(tempBox)
        createCoin(tempBox)
        if soundOn == true {
            coinSound.prepareToPlay()
            bonusSound.prepareToPlay()
        }
        fadeIn(tempBox)
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
            livesLbl.text = "Rides : \(lives)"
            
            if bonusCounter <= 5  && currentBonus != "FreeRide"{
                bonusLbl.text = "\(bonusMessage)"
            } else if currentBonus == "FreeRide" && bonusCounter <= 50 {
                bonusLbl.text = "\(bonusMessage)"
            } else {
                bonusLbl.text = ""
            }
            
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
            
        }
        
    }
    
    
    func createCoin(_ box : SCNNode){
       
        if boxCounter >= 5 {
        scene.physicsWorld.gravity = SCNVector3Make(0, 0, 0)
        let spin = SCNAction.rotate(by: CGFloat(M_PI * 2), around: SCNVector3Make(0, 0.5 , 0) , duration: 0.75)
        var coinFreq = UInt32()
        if speedName == "Slow" {
            coinFreq = 9
        } else if speedName == "Hyper-Active" {
            coinFreq = 7
        } else if speedName == "Ludicrous" {
            coinFreq = 5
        }
        
            if currentBonus != "FreeRide" {
        let bonusNumber = arc4random() % 66
        if bonusNumber == 7 {
            let bonusScene = SCNScene(named: "cone.dae")
            let bonus = bonusScene?.rootNode.childNode(withName: "Cone", recursively: true)
            bonus?.position = SCNVector3Make(box.position.x, box.position.y + 1, box.position.z)
            bonus?.scale = SCNVector3Make(0.3, 0.3, 0.3)
            
            bonus?.physicsBody = SCNPhysicsBody(type: SCNPhysicsBodyType.dynamic, shape: SCNPhysicsShape(node: bonus!, options: nil))
            bonus?.physicsBody?.categoryBitMask = bodyNames.Bonus
            bonus?.physicsBody?.contactTestBitMask = bodyNames.Person
            bonus?.physicsBody?.collisionBitMask = bodyNames.Person
            bonus?.physicsBody?.isAffectedByGravity = false
            
            scene.rootNode.addChildNode(bonus!)
            bonus?.runAction(SCNAction.repeatForever(spin))
            fadeIn(bonus!)
            
        } else {
            
            let randomNumber = arc4random() % coinFreq
            if randomNumber == 1{
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
                    
            } else {
                let randomNumber = arc4random() % coinFreq
                if randomNumber == 1{
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
            
        }
        
    }
    
    
    func bonusAction() {
        var bonusSpeed = Float()
        if kidsModeOn == false {
        bonusSpeed = Float(speed) / Float(startingSpeed)
        } else {
            bonusSpeed = Float(speed) / Float(startingSpeed/2)
        }
        
        
        let bonusRandom = arc4random() % 4
        
        if bonusRandom == 0 && lives < 5 {
            
            currentBonus = "Pink"
            
        } else if bonusRandom == 1 {
            
            currentBonus = "Blue"
            
        } else if bonusRandom == 2{
            
            currentBonus = "Green"
        
        } else if bonusRandom == 3 {
            
            currentBonus = "FreeRide"
        }
        
        
        if currentBonus == "Green" && bonusSpeed >= 0.65 {
            var percentage = Float(speed)
            percentage = percentage * 0.1
            var multiplier = Int()
            multiplier = Int(percentage)
            
            speed = speed - multiplier
            self.view.backgroundColor = UIColor(red: 0.0, green: 0.588, blue: 0.533, alpha: 1.0)
            bonusMessage = "Slow Down!"
            
        } else if currentBonus == "Pink" {
            lives += 1
            self.view.backgroundColor = UIColor(red: 0.847, green: 0.105, blue: 0.380, alpha: 1.0)
            bonusMessage = "Free Ride!"
        } else if currentBonus == "Blue" {
            score += 500
            self.view.backgroundColor = UIColor(red: 0.011, green: 0.607, blue: 0.898, alpha: 1.0)
            bonusMessage = "500 points!"
            
        } else if currentBonus == "FreeRide" {
            self.view.backgroundColor = UIColor(red: 0.623, green: 0.152, blue: 0.690, alpha: 1.0)
            bonusMessage = "AutoPilot!"
        }
        
        bonusCounter = 0
        addScore()
       
        
    }
    
    
    func fadeIn(_ node : SCNNode){
        
        node.opacity = 0
        node.runAction(SCNAction.fadeIn(duration: 0.5))
        
    }

    
    func fadeOutx(_ node : SCNNode){
        
        
        let move = SCNAction.move(to: SCNVector3Make(node.position.x + 5, node.position.y, node.position.z), duration: 0.5)
        node.runAction(move)
        node.runAction(SCNAction.fadeOut(duration: 0.5))
        
    }
    
    
    func fadeOutz(_ node : SCNNode){
        
        boxMaterial.diffuse.contents = nil
        let move = SCNAction.move(to: SCNVector3Make(node.position.x, node.position.y, node.position.z + 5), duration: 0.5)
        node.runAction(move)
        node.runAction(SCNAction.fadeOut(duration: 0.5))
    }
    
    func fadeOuty(_ node : SCNNode){
        
        boxMaterial.diffuse.contents = nil
        let move = SCNAction.move(to: SCNVector3Make(node.position.x, node.position.y - 10, node.position.z), duration: 0.5)
        node.runAction(move)
        node.runAction(SCNAction.fadeOut(duration: 0.5))
    }
    

    
    
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        
        let nodeA = contact.nodeA
        let nodeB = contact.nodeB
        if nodeA.physicsBody?.categoryBitMask == bodyNames.Coin && nodeB.physicsBody?.categoryBitMask == bodyNames.Person{
            
            nodeA.geometry?.firstMaterial?.diffuse.contents = nil
            nodeA.removeFromParentNode()
            score += 10
                addScore()
            
            if soundOn == true {
                coinSound.play()
            }
        }
            
            
            
        else if nodeA.physicsBody?.categoryBitMask == bodyNames.Person && nodeB.physicsBody?.categoryBitMask == bodyNames.Coin{
            
            nodeB.geometry?.firstMaterial?.diffuse.contents = nil
            nodeB.removeFromParentNode()
            score += 10
                addScore()
            
            if soundOn == true {
                coinSound.play()
            }
            
        } else if nodeA.physicsBody?.categoryBitMask == bodyNames.Person && nodeB.physicsBody?.categoryBitMask == bodyNames.Bonus{
            nodeB.geometry?.firstMaterial?.diffuse.contents = nil
            nodeB.removeFromParentNode()
            
            if soundOn == true {
            bonusSound.play()
            }
            bonusAction()
        } else if nodeA.physicsBody?.categoryBitMask == bodyNames.Bonus && nodeB.physicsBody?.categoryBitMask == bodyNames.Person{
            nodeA.geometry?.firstMaterial?.diffuse.contents = nil
            nodeA.removeFromParentNode()
            
            if soundOn == true {
            bonusSound.play()
            }
            bonusAction()
            
            
            
        }
    }
     
        func playSound() {
            let path = URL(fileURLWithPath: Bundle.main.path(forResource: "coin", ofType: "wav")!)
    
            do {
                try coinSound = AVAudioPlayer(contentsOf: path)
    
            } catch let err as NSError {
                print(err.debugDescription)
            }
            
            let path2 = URL(fileURLWithPath: Bundle.main.path(forResource: "bonus", ofType: "wav")!)
            
            do {
                try bonusSound = AVAudioPlayer(contentsOf: path2)
            } catch let err2 as NSError {
                print(err2.debugDescription)
            }
            
            
            
            try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
            try! AVAudioSession.sharedInstance().setActive(true)
            coinSound.volume = 0.4
            bonusSound.volume = 0.4
            
        }
    
    func playMusic() {
        
        
        let path3 = URL(fileURLWithPath: Bundle.main.path(forResource: "track", ofType: "wav")!)
        
        do {
            try soundtrack = AVAudioPlayer(contentsOf: path3)
        } catch let err3 as NSError {
            print(err3.debugDescription)
        }
        
        
        
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback, with: [])
        try! AVAudioSession.sharedInstance().setActive(true)
        
        soundtrack.volume = 0.4
    }

    
    
    
    func die(){
        
        
        if musicOn == true {
            
            soundtrack.stop()
        }
        let wait = SCNAction.wait(duration: 0.75)
        loseLife()
    
        if lives != -1{
            
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

    
    func gameOverFunc(){
        updatedScores()
        let scoreDefault = UserDefaults.standard
        scoreDefault.set(highscore, forKey: "highscore")
        
        let wait = SCNAction.wait(duration: 0.75)
        personMat.diffuse.contents = nil
        boxMaterial.diffuse.contents = nil
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
    
    

    func updatedScores(){
        let savedHighScore2 = UserDefaults.standard
        let savedHighScore3 = UserDefaults.standard
        let savedHighScore4 = UserDefaults.standard
        let savedHighScore5 = UserDefaults.standard
        let savedHighScore6 = UserDefaults.standard
        let finalScore = UserDefaults.standard
        
        if score > highscore {
            
        }
        
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
        }
        
        savedHighScore2.set(highScore2, forKey: "savedHighScore2")
        savedHighScore3.set(highScore3, forKey: "savedHighScore3")
        savedHighScore4.set(highScore4, forKey: "savedHighScore4")
        savedHighScore5.set(highScore5, forKey: "savedHighScore5")
        savedHighScore6.set(highScore6, forKey: "savedHighScore6")
        finalScore.set(score, forKey: "finalScore")
    }
    

    
    func Action(_ sender: UIButton!){
        self.performSegue(withIdentifier: "newsegue", sender: nil)
    }
    
}
