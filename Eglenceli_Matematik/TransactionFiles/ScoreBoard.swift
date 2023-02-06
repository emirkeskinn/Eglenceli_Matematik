//
//  ScoreBoard.swift
//  Eglenceli_Matematik
//
//  Created by Emir Keskin on 31.01.2023.
//

import UIKit

class ScoreBoard: UIViewController {

    @IBOutlet weak var sure1Label: UILabel!
    @IBOutlet weak var sure2Label: UILabel!
    @IBOutlet weak var sure3Label: UILabel!
    @IBOutlet weak var sure4Label: UILabel!
    @IBOutlet weak var sure5Label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var myUserName: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   imageView.image = UIImage(named: "koyuMavi")

        backToFuture()
    }
    

    func backToFuture() {
            let backVC = MixedQuestions()
        print(backVC.scoreBoard)
         if let skorTablom = UserDefaults.standard.object(forKey: "surem7") {
            let skorTablom2 = skorTablom
            print("UD set edilen skor tablosu VDL (skorTablosu.append(time)): \(skorTablom2)")
             backVC.scoreBoard = skorTablom2 as! [String]
             backVC.scoreBoard =  backVC.scoreBoard.sorted()
            print("skorTablosu Son Hali: \(backVC.scoreBoard)")
            sure1Label.text = "\(myUserName ?? "") \(backVC.scoreBoard[0])"
            sure2Label.text = "\(myUserName ?? "") \(backVC.scoreBoard[1])"
            sure3Label.text = "\(myUserName ?? "") \(backVC.scoreBoard[2])"
            sure4Label.text = "\(myUserName ?? "") \(backVC.scoreBoard[3])"
            sure5Label.text = "\(myUserName ?? "") \(backVC.scoreBoard[4])"
            
          }

    

}
}
