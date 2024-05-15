//
//  SeatsVC.swift
//  MovieTicketBooking
//
//  Created by Natthapat Liawpairoj on 30/4/2567 BE.
//

import UIKit

final class SeatsViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak private var seatsCV: UICollectionView!
    @IBOutlet weak private var sessionLabel: UILabel!
    @IBOutlet weak private var selectedSeatsLabel: UILabel!
    @IBOutlet weak private var priceLabel: UILabel!
    @IBOutlet weak private var ticketsLabel: UILabel!
    
    // MARK: - Variables
    
    var movie: Movie?
    var session: Session?
    private var seats: [Seat] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createSeats()
        sessionLabel.text = session?.toString()
        seatsCV.setup("SeatCVC", SeatsFlowLayout())
    }
    
    // MARK: - Functions

    // Create seats for the cinema layout.
    private func createSeats() {
        guard let movie = movie, let session = session else { return }
        let soldSeats: [Seat] = Ticket.soldSeats(movie: movie, session: session)
        for section in 0..<8 {
            for row in 0..<9 {
                var seat = Seat(section, row)
                if soldSeats.contains(where: { soldSeat in soldSeat.isIdentical(seat) }) {
                    seat.sold = true
                }
                seats.append(seat)
            }
        }
    }

    // Filter selected seats from all seats.
    private func selectedSeats() -> [Seat] { seats.filter { $0.selected } }

    // Calculate the number of selected seats.
    private func selectedSeatsCount() -> Int { selectedSeats().count }

    // Generate seat code representing selected seats.
    private func selectedSeatsCodes() -> String {
        let selectedSeatCodes = selectedSeats().map { seat in seat.seatCode }
        return selectedSeatCodes.joined(separator: ", ")
    }

    // Calculate the total price for selected seats based on a fixed price of $20 per seat.
    private func calculateTotalPrice() -> Double { Double(selectedSeatsCount()) * 20.0 }
        
    private func seatIndexOf(_ indexPath: IndexPath) -> Int {
        return indexPath.section * 9 + indexPath.row
    }

    // Handle seat selection and deselection.
    private func seatOnTap(_ index: Int) {
        guard seats[index].sold != true else { return }
        let isSelected = seats[index].selected
        // Check if the selection limit is reached and toggle seat selection.
        guard selectedSeatsCount() < 10 || isSelected else {
            self.showToast("You can not buy more than 10 tickets") 
            return
        }
        seats[index].selected = !isSelected
        seatsCV.reloadData()
        ticketsLabel.text = String(selectedSeatsCount())
        selectedSeatsLabel.text = selectedSeatsCodes()
        priceLabel.text = calculateTotalPrice().toString()
    }
    
    // MARK: - Actions

    // Action triggered by pressing the "Buy Tickets" button.
    @IBAction private func btnBuyTickets_TUI(_ sender: Any) {
        // Check if any seats have been selected.
        guard selectedSeatsCount() > 0 else {
            self.showToast("Please choose at least 1 seat")
            return
        }
        // Create the ticket and navigate to confirmation page.
        let ticketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TicketVC") as! TicketViewController
        let ticket = Ticket(movie: movie!, session: session!, seats: selectedSeats(), price: calculateTotalPrice())
        ticketVC.ticket = ticket
        navigationController?.pushViewController(ticketVC, animated: true)
    }
}

extension SeatsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCVC", for: indexPath) as! SeatCVC
        let seat: Seat = seats[seatIndexOf(indexPath)]
        cell.setupCell(seat)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        seatOnTap(seatIndexOf(indexPath))
    }
}

