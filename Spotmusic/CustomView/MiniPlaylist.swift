//
//  MiniPlaylist.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 25/06/21.
//

import UIKit

class MiniPlaylist: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var playlistNameLabel: UILabel!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let nib = UINib(nibName: "MiniPlaylist", bundle: .main)
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        self.contentView = contentView
    }
}
