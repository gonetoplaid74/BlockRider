//
//  SettingsVC.swift
//  pathFinder
//
//  Created by AW on 23/09/2016.
//  Copyright © 2016 Allan Wallace. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SettingsVC: UIViewController {

    @IBOutlet weak var topBar: UIView!
    @IBOutlet weak var doneBtn: UIButton!
    @IBOutlet weak var soundFXLbl: UILabel!
    
    @IBOutlet weak var diffLbl: UILabel!
    @IBOutlet weak var colourLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var colourChoose: UISegmentedControl!
    @IBOutlet weak var diffChoose: UISegmentedControl!
    
    @IBOutlet weak var kidsBtn: UISwitch!
    @IBOutlet weak var kidsLbl: UILabel!
 
    @IBOutlet weak var soundOff: UISwitch!
    @IBOutlet weak var bottomBar: UIView!
    @IBOutlet weak var musicOff: UISwitch!
    
    
    var speed = String()
    var personSpeed = Int()
    @IBOutlet weak var musicLBL: UILabel!
    var colour = String()
    var colourScheme = String()
    var ad = GADBannerView()
    var mainColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        let colourSchemeChoice = UserDefaults.standard
        let diffChosen = UserDefaults.standard
        let kidsMode = UserDefaults.standard
        let soundMode = UserDefaults.standard
        let musicMode = UserDefaults.standard
        
        if kidsMode.bool(forKey: "kidsMode") == false || kidsMode.bool(forKey: "kidsMode") == true {
            kidsBtn.isOn = kidsMode.bool(forKey: "kidsMode")
            
            
        } else {
        kidsMode.set(false, forKey: "kidsMode")
        kidsBtn.isOn = false
            
            
        
        }
        if soundMode.string(forKey: "soundMode") == nil {
            soundMode.set(true, forKey: "soundMode")
        }
        
        if soundMode.bool(forKey: "soundMode") == true || soundMode.bool(forKey: "soundMode") == false {
            soundOff.isOn = soundMode.bool(forKey: "soundMode")
            
        } else {
            soundMode.set(true, forKey: "soundMode")
            soundOff.isOn = true
        }
        if musicMode.string(forKey: "musicMode") == nil {
            musicMode.set(true, forKey: "musicMode")
        }

        
        if musicMode.bool(forKey: "musicMode") == true || musicMode.bool(forKey: "musicMode") == false {
            musicOff.isOn = musicMode.bool(forKey: "musicMode")
            
        } else {
            musicMode.set(true, forKey: "musicMode")
            musicOff.isOn = true
            }
        
      
        
        
        
        if diffChosen.string(forKey: "startingSpeed") == nil {
            speed = "Slow"
            
        } else {
            speed = diffChosen.string(forKey: "startingSpeed")!
        }
      
        if speed == "Slow" {
            diffChoose.selectedSegmentIndex = 0
        } else if speed == "Hyper-Active" {
            diffChoose.selectedSegmentIndex = 1
        } else if speed == "Ludicrous" {
            diffChoose.selectedSegmentIndex = 2
        }
        
        if colourSchemeChoice.string(forKey: "chosenColourScheme") == nil {
            colourScheme = "blue"
        } else {
            colourScheme = colourSchemeChoice.string(forKey: "chosenColourScheme")!
        }
        
        doneBtn.layer.cornerRadius = 6.0
        doneBtn.layer.shadowRadius = 6.0
        doneBtn.layer.shadowOpacity = 0.8
        doneBtn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)

        if colourScheme == "pink" {
            mainColor = PINK_COLOR
            colorChange()
            colourChoose.selectedSegmentIndex = 1
            
            
        } else if colourScheme == "blue" {
            mainColor = BLUE_COLOR
            colorChange()
            colourChoose.selectedSegmentIndex = 0
        
        }  else if colourScheme == "random" {
            
            let red = CGFloat((arc4random()%10)+2)/12
            let green = CGFloat((arc4random()%10)+2)/12
            let blue = CGFloat((arc4random()%10)+2)/12
            
            mainColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
            RANDOM_COLOR = mainColor
            colorChange()
            colourChoose.selectedSegmentIndex = 2

        }
        
                
    }

    @IBAction func colourSelector(_ sender: AnyObject) {
        let storeColour = UserDefaults.standard
        
    
        
        
        if colourChoose.selectedSegmentIndex == 0 {
            colour = "blue"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
        } else if colourChoose.selectedSegmentIndex == 1 {
         colour = "pink"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
        } else if colourChoose.selectedSegmentIndex == 2 {
            colour = "random"
            storeColour.set(colour, forKey: "chosenColourScheme")
            
            
            
        }
        
        colourScheme = colour
        
        
    viewDidLoad()
    
    
    
    }
    
    func colorChange() {
        topBar.backgroundColor = mainColor
        doneBtn.backgroundColor = mainColor
        titleLbl.textColor = mainColor
        diffLbl.textColor = mainColor
        colourLbl.textColor = mainColor
        soundFXLbl.textColor = mainColor
        colourChoose.tintColor = mainColor
        diffChoose.tintColor = mainColor
        musicLBL.textColor = mainColor
        musicOff.tintColor = mainColor
        musicOff.onTintColor = mainColor
       
        soundOff.onTintColor = mainColor
        soundOff.tintColor = mainColor
        bottomBar.backgroundColor = mainColor
        kidsLbl.textColor = mainColor
        kidsBtn.onTintColor = mainColor
        kidsBtn.tintColor = mainColor
    }
    
    
    @IBAction func diffChooseBtn(_ sender: AnyObject) {
        
        let chosenDiff = UserDefaults.standard
        
        if diffChoose.selectedSegmentIndex == 0{
            speed = "Slow"
            
        } else if diffChoose.selectedSegmentIndex == 1 {
            speed = "Hyper-Active"
        } else if diffChoose.selectedSegmentIndex == 2 {
            speed = "Ludicrous"
        }
        
        chosenDiff.set(speed, forKey: "startingSpeed")
    }
    
  
    @IBAction func kidsModSlider(_ sender: AnyObject) {
        
        let kidsMode = UserDefaults.standard
        
        
        if kidsBtn.isOn == true {
            kidsMode.set(true, forKey: "kidsMode")
        } else {
            kidsMode.set(false, forKey: "kidsMode")
        }
        
       
    }
        
        
        
    
    
    @IBAction func musicSlider(_ sender: Any) {
        let musicMode = UserDefaults.standard
        
        if musicOff.isOn == true {
            musicMode.set(true, forKey: "musicMode")
        } else  {
            musicMode.set(false, forKey: "musicMode")
        }

        
    }
    
    
    @IBAction func sounfFXSlider(_ sender: Any) {
        
        let soundMode = UserDefaults.standard
        
        if soundOff.isOn == true {
            soundMode.set(true, forKey: "soundMode")
        } else  {
            soundMode.set(false, forKey: "soundMode")
        }
        
    }
    


}
