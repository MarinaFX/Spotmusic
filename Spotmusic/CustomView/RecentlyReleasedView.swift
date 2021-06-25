//
//  RecentlyReleasedView.swift
//  Spotmusic
//
//  Created by Marina De Pazzi on 25/06/21.
//

import UIKit

class RecentlyReleasedView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder){
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let nib = UINib(nibName: "RecentlyReleasedView", bundle: .main)
        let contentView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        contentView.translatesAutoresizingMaskIntoConstraints = true
        
        self.contentView = contentView
    }

}
