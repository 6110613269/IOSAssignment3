//
//  Movie.swift
//  MovieTicketBooking
//
//  Created by Natthapat Liawpairoj on 28/4/2567 BE.
// 

import Foundation
import UIKit

// Enum representing different movie genres
enum Genre: String, Codable {
    case Action
    case Comedy
    case Drama
    case Fantasy
    case Horror
    case Romance
    case Thriller
    case Crime
    case SciFi = "Sci-Fi"
}

// Enum representing movie content ratings
enum ContentRating: String, Codable {
    case PG
    case PG13 = "PG-13"
    case R
}

// Banner
struct Banner {
    var image: String
    var title: String
}

// Struct representing a movie. Contains properties for image filename, title, synopsis, screening dates, duration, genres, content rating, director, and cast.
// The screeningDate property holds an array of Date objects representing screening dates.
struct Movie: Codable {
    var imageName: String
    var title: String
    var synopsis: String
    var screeningDate: [Date]
    var duration: Int
    var genres: [Genre]
    var contentRating: ContentRating
    var director: String
    var cast: [String]
    
    init(
    image imageAssetName: String,
    title: String,
    filmReview: String,
    screeningDates: [Date],
    duration: Int,
    genres: [Genre],
    contentRating: ContentRating,
    director: String,
    cast: [String]
    )
    {
      
    self.imageName = imageAssetName
    self.title = title
    self.synopsis = filmReview
    self.screeningDate = screeningDates
    self.duration = duration
    self.genres = genres
    self.contentRating = contentRating
    self.director = director
    self.cast = cast
  }

  // Checks if two Movie instances are identical based on title, director, and screening dates.
    func isIdentical(_ other: Movie) -> Bool {
        return title == other.title &&
        director == other.director &&
        screeningDate.elementsEqual(other.screeningDate)
    }
  
  // Converts duration in minutes to a string representation in hours and minutes.
    func durationString() -> String {
        let hour: Int = Int(floor(Double(duration) / 60))
        let minute: Int = duration - hour * 60
        let hourStr = hour > 1 ? "Hours" : "Hour"
        return "\(hour) \(hourStr) \(minute > 0 ? "\(minute) Minutes" : "")"
    }

  // Converts an array of screening dates to a string with a formatted date.
    func releaseDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return screeningDate.map { formatter.string(from: $0) }.joined(separator: ", ")
    }
  
// Converts an array of Genre enums to a string of genre names.
    func genresString() -> String {
        var Genres: [String] = []
        for i in 0..<genres.count {
            Genres.append(genres[i].rawValue)
        }
        return Genres.joined(separator: ", ")
    }
  
  // Creates an attributed string representing the movie's cast list.
    func castList() -> NSAttributedString {
        let castString = NSAttributedString(
            string: "Cast: ",
            attributes: [.font: UIFont.systemFont(ofSize: 17, weight: .medium)]
        )
        let list = NSAttributedString(
            string: cast.joined(separator: ", "),
            attributes: [.font: UIFont.systemFont(ofSize: 17)]
        )
        let castList = NSMutableAttributedString()
        castList.append(castString)
        castList.append(list)
        return castList
    }
}

// Loads an image from the asset catalog using the string as the image name.
extension String {
    func loadImageString() -> UIImage? {
        UIImage(named: self)
    }
}

// This extension provides static functions to retrieve movie screening dates.
extension Movie {
    private static func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
  
  // Function to convert a date string to an array of Date objects
    private static func dateFromString(_ dateString: String) -> [Date] {
        guard let date = dateFormatter().date(from: dateString) else { return [] }
        return [date]
    }
  
  // Static functions screening dates for each movie
    static func screeningDatesForPulpFiction() -> [Date] {
        return dateFromString("07/05/2024")
    }

    static func screeningDatesForTheGodfather() -> [Date] {
        return dateFromString("14/05/2024")
    }

    static func screeningDatesForBackToTheFuture() -> [Date] {
        return dateFromString("21/05/2024")
    }

    static func screeningDatesForKillBill() -> [Date] {
        return dateFromString("28/05/2024")
    }

    static func screeningDatesForJaws() -> [Date] {
        return dateFromString("04/06/2024")
    }

    static func screeningDatesForForrestGump() -> [Date] {
        return dateFromString("11/06/2024")
    }

    static func screeningDatesForShawShankRedemption() -> [Date] {
        return dateFromString("18/06/2024")
    }

    static func screeningDatesForTheMatrix() -> [Date] {
        return dateFromString("25/06/2024")
    }
}

