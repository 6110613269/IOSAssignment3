//
//  Seat.swift
//  MovieTicketBooking
//
//  Created by Natthapat Liawpairoj on 28/4/2567 BE.
//

import Foundation

// Contains properties for section, row, selected (whether the seat is selected by the user, sold (whether the seat is sold), and a computed property seatCode representing the unique code of the seat.
struct Seat: Codable {
    var section: Int
    var row: Int
    var selected: Bool
    var sold: Bool
    var seatCode: String { get { "\(["A", "B", "C", "D", "E", "F", "G", "H"][section])\(row + 1)" } }
    
    // Checks if two Seat instances are identical based on their seatCode.
    func isIdentical(_ otherSeat: Seat) -> Bool { seatCode == otherSeat.seatCode }

    // Parameters include section, row, selected (defaulted to false), and sold (defaulted to false)
    init(_ section: Int, _ row: Int, selected: Bool = false, sold: Bool = false) {
        self.section = section
        self.row = row
        self.selected = selected
        self.sold = sold
    }
}
