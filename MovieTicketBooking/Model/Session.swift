//
//  Session.swift
//  MovieTicketBooking
//
//  Created by Natthapat Liawpairoj on 1/5/2567 BE.

//

import Foundation

// Represents a session or event, conforming to Codable for encoding/decoding
// Contains properties for date, id (formatted as "dd/MM/yyyy HH:mm"), month, day, and time.
struct Session: Codable {
    var date: Date
    var id: String { date.toString("dd/MM/yyyy HH:mm") }
    var month: String { date.month() }
    var day: String { String(date.day()) }
    var time: String {
        get { date.time() }
        set {
            if let newDate = DateFormatter.format("dd/MM/yyyy HH:mm", "\(date.toString()) \(newValue)") {
                date = newDate
            }
        }
    }
    
    func isIdentical(_ session: Session?) -> Bool {
        guard let session = session else { return false }
        return id == session.id
    }
    
    // Initializes a Session instance with provided date.
    init(date: Date) {
        self.date = date
    }
}

// Provides a static method to format a string to a Date object using a specified format
private extension DateFormatter {
    static func format(_ format: String, _ dateString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: dateString)
    }
}
