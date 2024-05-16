//
//  CVCell_Movie2.swift
//  MovieTicketBooking
//
//  Created by Natthapat Liawpairoj on 27/4/2567 BE.
//

import UIKit

class MovieCVC: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak private var imageIV: UIImageView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var screeningDatesLabel: UILabel!
    
    // MARK: - Functions
    // Configures the cell with movie data
    func setupCell(_ movie: Movie) {
        imageIV.image = movie.imageName.loadImageString()
        titleLabel.text = movie.title
        setScreeningDates(movie)
    }
    
    // Sets the screening dates for the movie
    private func setScreeningDates(_ movie: Movie) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"  // Customize the date format
        let screeningDatesString = movie.screeningDate.map { formatter.string(from: $0)
        }.joined(separator: ", ")
        screeningDatesLabel.text = "\(screeningDatesString)"
    }
}
