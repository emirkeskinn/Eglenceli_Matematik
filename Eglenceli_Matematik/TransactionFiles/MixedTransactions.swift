//
//  MixedTransactions.swift
//  Eglenceli_Matematik
//
//  Created by Emir Keskin on 31.01.2023.
//

import UIKit
import AVFoundation

class MixedTransactions: UIViewController {

    
    
    @IBOutlet weak var rightTitle: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    @IBOutlet weak var wrongTitle: UILabel!
    @IBOutlet weak var wrongLabel: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var questionLabel1: UILabel!
    @IBOutlet weak var questionLabel2: UILabel!
    @IBOutlet weak var questionLabel3: UILabel!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var wellDoneLabel: UILabel!
    @IBOutlet weak var wellDoneLabel2: UILabel!
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var equalLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    
    @IBOutlet var labels: [UILabel]!
    
    var audioPlayer = AVAudioPlayer()
    
    var randomIndex: Int?
    var currentIndex = 0
    
    var images = [UIImage(named: "1")]
    
    var question: String?
    var answer: String?
    var sonuc: Int!
    var right: Int = 0
    var wrong: Int = 0
    var userAnswer: String?
    
    var timer = Timer()
    var counter: Int?
    
    var sonucToplama: Int?
    var sonucCikarma: Int?
    var sonucCarpma: Int?
    var sonucBolme: Int?
    var sonucTFtoplama: Int?
    
    var soru1: String?
    var soru2: String?
    var soru3: String?
    var soru31: String?

    var result: Int?
    var labelSonuc: String = "error"
    var yourTime: String?
    var seconds = 0
    var scoreBoard: [String] = ["5.00" ]
    var myisim: String!
    
    var sayilarim = [5,8,10]
    
    var buttonsAreHidden = true
    var timeKeysHiddeny = true
    var hideButtons = true
    var switchKey = "difficulty"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = UIImage(named: "gokce4")
        toggleButtons() // True - False
        timeKeysHidden()
        allButtonsHidden()
        

        easyButton.layer.cornerRadius = 10
        normalButton.layer.cornerRadius = 10
        hardButton.layer.cornerRadius = 10


        self.view.bringSubviewToFront(aButton)
        self.view.bringSubviewToFront(bButton)
        self.view.bringSubviewToFront(cButton)
        self.view.bringSubviewToFront(dButton)
        self.view.bringSubviewToFront(trueButton)
        self.view.bringSubviewToFront(falseButton)
        
        self.view.bringSubviewToFront(easyButton)
        self.view.bringSubviewToFront(normalButton)
        self.view.bringSubviewToFront(hardButton)
        self.view.bringSubviewToFront(wellDoneLabel2)
    }
    
// ----------  TIME TRANSACTIONS -- SCORE TRANSACTIONS AND TABLES  ----------------
    
    func startTimer() {
        seconds = 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }

    @objc func updateCounter() {
        seconds += 1
        timeLabel.text = "\(seconds)"
    }
    
    
    func stopTimer() {
        timer.invalidate()
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        let time = "\(minutes) Dakika :\(remainingSeconds < 10 ? "0\(remainingSeconds)" : "\(remainingSeconds) Saniye")"
        print("time: \(time)")
        yourTime = time
        
        scoreBoard.append(time)
        print(("skorTablosu.append: \(time)"))
        
         UserDefaults.standard.set(time, forKey: "sure")
        if let myTimer = UserDefaults.standard.object(forKey: "sure") {
                     let timerim2 = myTimer
                     print("UD set edilen time: \(timerim2)")
                 }

    }
    
    
    func scoreBoarding() {
        rightLabel.text = "\(right)"
        wrongLabel.text = "\(wrong)"
    }
    
//------------ END -------------------------------------------------------------

    
    
    
    
// ------------ VOICES ----------------------------------------------------

    func applaud() {
        let alkis = Bundle.main.url(forResource: "alkis", withExtension: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: alkis!)
    audioPlayer.prepareToPlay()
    audioPlayer.play()
    }
    
    func tabiEfendim() {
        let soundURL = Bundle.main.url(forResource: "ses2", withExtension: "mp3")
    audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
    audioPlayer.prepareToPlay()
    audioPlayer.play()
    }
    
    
    
//------------ END -------------------------------------------------------------

    
    
// ----------- ALERT FUNCTIONS ------------------------------------------------
    
    
    func theEndAlert(titleM: String, messageM: String) {
        
        let alertController = UIAlertController(title: titleM, message: messageM, preferredStyle: .alert)
           let okAction = UIAlertAction(title: "Tamam", style: .default) { (action) in
               let newViewController = ScoreBoard() // Create a new view controller
               self.navigationController?.pushViewController(newViewController, animated: true)
               self.performSegue(withIdentifier: "toScorVC", sender: nil)
               print("pushViewController called")
           }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
        print("pushViewController called2")
    }



    func makeAlert(titleM: String, messageM: String) {
        if self.presentedViewController == nil {
        let alert = UIAlertController(title: titleM, message: messageM, preferredStyle: UIAlertController.Style.alert)
        
        let okButton = UIAlertAction(title: "Yeniden Başla", style: UIAlertAction.Style.default, handler: nil)
        
        let okAction = UIAlertAction(title: "Ana Menüye Dön", style: .default) { (action) in
            self.dismiss(animated: true, completion: nil)
            //self.navigationController?.popViewController(animated: true)
        }

        alert.addAction(okAction)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    
       
        } else {
            print("sıkıntı var")
        }
    }
    
    
    
    
    
    
//------------ END -------------------------------------------------------------

    
    
    
    
    
// ----------------FUNCTIONS ---------------------------------------------
      
        func allButtonsHidden() {
            if hideButtons {
                easyButton.layer.isHidden = false
                normalButton.layer.isHidden = false
                hardButton.layer.isHidden = false
                imageView.layer.isHidden = false
                aButton.layer.isHidden = true
                bButton.layer.isHidden = true
                cButton.layer.isHidden = true
                dButton.layer.isHidden = true
                answerLabel.layer.isHidden = true
                questionLabel1.layer.isHidden = true
                questionLabel2.layer.isHidden = true
                questionLabel3.layer.isHidden = true
                wellDoneLabel.layer.isHidden = true
                wellDoneLabel2.layer.isHidden = true
                iconLabel.layer.isHidden = true
                equalLabel.layer.isHidden = true

                hideButtons = false
            } else {
                easyButton.layer.isHidden = true
                normalButton.layer.isHidden = true
                hardButton.layer.isHidden = true
                imageView.layer.isHidden = false
                aButton.layer.isHidden = false
                bButton.layer.isHidden = false
                cButton.layer.isHidden = false
                dButton.layer.isHidden = false
                answerLabel.layer.isHidden = false
                questionLabel1.layer.isHidden = false
                questionLabel2.layer.isHidden = false
                questionLabel3.layer.isHidden = false
                wellDoneLabel.layer.isHidden = false
                wellDoneLabel2.layer.isHidden = false
                iconLabel.layer.isHidden = false
                equalLabel.layer.isHidden = false
                hideButtons = true
            }
        }
        
        
        func timeKeysHidden() {
            if timeKeysHiddeny {
                timeTitle.layer.isHidden = true
                timeLabel.layer.isHidden = true
                rightTitle.layer.isHidden = true
                rightLabel.layer.isHidden = true
                wrongTitle.layer.isHidden = true
                wrongLabel.layer.isHidden = true
                answerLabel.layer.isHidden = true
                timeKeysHiddeny = false
            } else {
                timeTitle.layer.isHidden = false
                timeLabel.layer.isHidden = false
                rightTitle.layer.isHidden = false
                rightLabel.layer.isHidden = false
                wrongTitle.layer.isHidden = false
                wrongLabel.layer.isHidden = false
                answerLabel.layer.isHidden = false
                timeKeysHiddeny = true
            }
        }
        
        func toggleButtons() {
            if buttonsAreHidden {
                trueButton.layer.isHidden = true
                falseButton.layer.isHidden = true
                buttonsAreHidden = false
            } else {
                trueButton.layer.isHidden = false
                falseButton.layer.isHidden = false
                buttonsAreHidden = true
            }
        }
        
        
        
// ----------------------END ---------------------------------------------

        
    
    
    
    
    
    
    
    
    
    
}

