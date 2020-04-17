//
//  ViewController.swift
//  VideoSlidePlay
//
//  Created by Hunter on 2020/4/14.
//  Copyright © 2020 Hunter. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

let cellHeight = UIScreen.main.bounds.height * 0.35

class ViewController: UIViewController {
    
    let videosCellID = "VideosCellID"
    var tableView: UITableView!
    let dataSource = ["video3", "video4", "video5", "video3", "video4", "video5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableViewUI()
    }
    
}
// MARK: - 设置页面UI
extension ViewController {
    
    func setTableViewUI() {
        
        tableView = UITableView.init(frame: self.view.bounds)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        
        //注册复用cell
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: videosCellID)
        
        view.addSubview(tableView)
        
    }
}
// MARK: - tableView的代理，委托，数据源协议
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    //设置cell的高度
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: videosCellID, for: indexPath) as! PlayerTableViewCell
        
        let filePath = Bundle.main.path(forResource: dataSource[indexPath.row], ofType: "MP4")
        
        let url = URL(fileURLWithPath: filePath!)
        
        let avPlayer = AVPlayer(url: url )
        cell.playerView.player = avPlayer
        cell.palyInfoLabel.text = String(filePath?.split(separator: "/").last?.split(separator: ".").first ?? "Videos Tutorial")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        pauseAllPlayer(indexpathSelect: indexPath)
        
        if let cell = tableView.cellForRow(at: indexPath) as? PlayerTableViewCell {
            
            let player = cell.playerView.player
            
            if player != nil && player!.rate != 0 {
                cell.pause()
            } else {
                cell.play()
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        handlePalyStatus()
        
    }
    
}
// MARK: - 内部方法
private extension ViewController {
    
    func handlePalyStatus() {
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows {
            if indexPathsForVisibleRows.isEmpty {
                return
            }
            
            var focusCell: PlayerTableViewCell?
            
            for indexPath in indexPathsForVisibleRows {
                if let cell = tableView.cellForRow(at: indexPath) as? PlayerTableViewCell {
                    if focusCell == nil {
                        let rect = tableView.rectForRow(at: indexPath)
                        if tableView.bounds.contains(rect) {
                            cell.play()
                            focusCell = cell
                        } else {
                            cell.pause()
                        }
                    } else {
                        cell.pause()
                    }
                }
            }
            
        }
    }
    
    func pauseAllPlayer(indexpathSelect: IndexPath) {
        guard let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows else {
            return
        }
        
        if indexPathsForVisibleRows.isEmpty {
            return
        }
        
        for indexPath in indexPathsForVisibleRows {
            if indexpathSelect == indexPath {
                continue
            }
            if let cell = tableView.cellForRow(at: indexPath) as? PlayerTableViewCell {
                cell.pause()
            }
        }
    }
}
