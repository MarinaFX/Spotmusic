//
//  PlayingViewController.swift
//  Spotmusic
//
//  Created by Hojin Ryu on 21/06/21.
//

import UIKit

class PlayingViewController: UIViewController {
    
    
    @IBOutlet weak var viewLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var playingNow: Music?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.text = playingNow?.title
        

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addTapped))
        
        
    }
    
    @objc func addTapped(){
        print("tapped")
    }
    

}
