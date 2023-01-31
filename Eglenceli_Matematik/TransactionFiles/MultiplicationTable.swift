//
//  MultiplicationTable.swift
//  Eglenceli_Matematik
//
//  Created by Emir Keskin on 31.01.2023.
//

import UIKit

class MultiplicationTable: UIViewController {

    @IBOutlet weak var ones: UIButton!
    @IBOutlet weak var twos: UIButton!
    @IBOutlet weak var threes: UIButton!
    @IBOutlet weak var fours: UIButton!
    @IBOutlet weak var fives: UIButton!
    @IBOutlet weak var sixes: UIButton!
    @IBOutlet weak var sevenths: UIButton!
    @IBOutlet weak var eights: UIButton!
    @IBOutlet weak var nines: UIButton!
    @IBOutlet weak var tenth: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var buttons: [UIButton]!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "kalp")
        ones.layer.cornerRadius = 10
        twos.layer.cornerRadius = 10
        threes.layer.cornerRadius = 10
        fours.layer.cornerRadius = 10
        fives.layer.cornerRadius = 10
        sixes.layer.cornerRadius = 10
        sevenths.layer.cornerRadius = 10
        eights.layer.cornerRadius = 10
        nines.layer.cornerRadius = 10
        tenth.layer.cornerRadius = 10
        
    }
    

    @IBAction func buttonTapped(_ sender: UIButton) {
        
        if let index = buttons.firstIndex(of: sender) {
            switch index {
            case 0:
                imageView.image = UIImage(named: "1x")
            case 1:
                imageView.image = UIImage(named: "2x")
            case 2:
                imageView.image = UIImage(named: "3x")
            case 3:
                imageView.image = UIImage(named: "4x")
            case 4:
                imageView.image = UIImage(named: "5x")
            case 5:
                imageView.image = UIImage(named: "6x")
            case 6:
                imageView.image = UIImage(named: "7x")
            case 7:
                imageView.image = UIImage(named: "9x")
            case 8:
                imageView.image = UIImage(named: "10x")
            case 9:
                imageView.image = UIImage(named: "8x")
            default:
                break
            }
            
               }
    }
 

}
