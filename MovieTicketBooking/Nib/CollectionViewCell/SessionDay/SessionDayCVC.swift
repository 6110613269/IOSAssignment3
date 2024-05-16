//
//  CVCell_Day.swift
//  MovieTicketBooking
//
//  Created by Natthapat Liawpairoj on 30/4/2567 BE.
//

import UIKit

class SessionDayCVC: UICollectionViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var backgroundUIView: UIView!
    @IBOutlet weak private var monthLabel: UILabel!
    @IBOutlet weak private var dayLabel: UILabel!
        
    // MARK: Functions
    // Configures the cell with session data and appearance
    func setupCell(session: Session,selected selectedCell: Bool) {
        
        // Define colors
        let bgColor: UIColor = selectedCell ? UIColor(named: "PrimaryColor") ?? UIColor.black : UIColor.white
        let textColor: UIColor = selectedCell ? UIColor.white : UIColor.black
        backgroundUIView.backgroundColor = bgColor
        monthLabel.textColor = textColor
        dayLabel.textColor = textColor
        monthLabel.text = session.month
        dayLabel.text = session.day
    }

}
