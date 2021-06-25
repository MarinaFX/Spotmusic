//
//  MiniPlayerView.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 24/06/21.
//

import UIKit

class MiniPlayerView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var reprodButton: UIButton!
    
    var playMusic: Bool = true
    
    @IBAction func playMusic(_ sender: UIButton) {
        playMusic.toggle()
        
        reprodButton.setImage(playMusic ? UIImage(systemName: "pause.circle.fill") : UIImage(systemName: "play.circle.fill"), for: .normal)
    }
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let nib = UINib(nibName: "MiniPlayerView", bundle: .main)
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView// carregando outlets
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        self.contentView = contentView
        
    }
}
