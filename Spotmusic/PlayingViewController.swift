//
//  PlayingViewController.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 21/06/21.
//

import UIKit

class PlayingViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    var playingNow: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = playingNow?.title
    }
    

}
