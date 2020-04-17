//
//  PlayerView.swift
//  VideoSlidePlay
//
//  Created by Hunter on 2020/4/14.
//  Copyright © 2020 Hunter. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class PlayerView: UIView {
    override static var layerClass: AnyClass {
        return AVPlayerLayer.self
    }
    
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
}
