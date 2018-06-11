//
//  PNOCell.swift
//  LifeARtistTest
//
//  Created by mohamed on 4/30/18.
//  Copyright © 2018 Mohamed ELfishawy. All rights reserved.
//

import UIKit
protocol providerorderCellDelegate {
    func didTapAccept(orderID: String,notificationID:Int)
    func didTapreject(orderID: String,notificationID:Int)
}


class PNOCell: UITableViewCell {
    
   var myTableViewController:proiderNotificationVC?
    var videoItem: notificationModel!
    var delegate:providerorderCellDelegate?
    
    @IBOutlet weak var Title: UILabel!
    
    func setVideo(video: notificationModel) {
        videoItem = video
       // Title.text = video.service
    }
    
    @IBAction func acceptButton(_ sender: Any) {
        delegate?.didTapAccept(orderID: videoItem.orderId,notificationID: videoItem.notificationId)
        myTableViewController?.deleteCell(cell: self)
        
    }
    @IBAction func rejectButton(_ sender: Any) {
        delegate?.didTapreject(orderID:  videoItem.orderId, notificationID: videoItem.notificationId)
        myTableViewController?.deleteCell(cell: self)
    }
//    func handleAction() {
//        myTableViewController?.deleteCell(self)
//    }
}
