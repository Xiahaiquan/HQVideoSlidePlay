//
//  PlayerTableViewCell.swift
//  VideoSlidePlay
//
//  Created by Hunter on 2020/4/14.
//  Copyright © 2020 Hunter. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    var playerView: PlayerView!
    var playStatusImg: UIImageView!
    var palyInfoLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addPlayerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addPlayerView() {
        playerView = PlayerView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: cellHeight))
        self.contentView.addSubview(playerView)
        
        palyInfoLabel = UILabel.init(frame: CGRect.init(x: 10, y: 10, width: self.contentView.bounds.width, height: 30))
        self.contentView.addSubview(palyInfoLabel)
        palyInfoLabel.textColor = .red
        
        let imgWidht:CGFloat = 20
        playStatusImg = UIImageView.init(image: UIImage.init(named: "Setting_Play"))
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.playStatusImg.frame = CGRect.init(x: (self.contentView.bounds.size.width - imgWidht) / 2, y: (self.contentView.bounds.size.height - imgWidht) / 2, width: imgWidht, height: imgWidht)
        }
        
        playStatusImg.contentMode = .scaleAspectFit
        playStatusImg.isHidden = false
        
        self.contentView.addSubview(playStatusImg)
        
    }
    
    func play() {
        playerView.player!.seek(to: .zero)
        
        playerView.player!.play()
        playStatusImg.isHidden = true
        
    }
    
    func pause() {
        playerView.player!.pause()
        
        playStatusImg.isHidden = false
        playStatusImg.image = UIImage.init(named: "Setting_Play")
    }
}

