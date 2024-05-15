//
//  MyTicketTableViewController.swift
//  MovieTicketBooking
//
//  Created by Natthapat Liawpairoj on 8/5/2567 BE.
//

import UIKit

class MyTicketTableViewController: UITableViewController {
  
  var tickets = [Ticket]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadTicket()
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }

  // Load tickets from UserDefaults.
  private func loadTicket() {
    let userDefault = UserDefaults.standard
    if let savedTicketData = userDefault.data(forKey: "savedTicket"),
       let savedTicket = try? JSONDecoder().decode([Ticket].self, from: savedTicketData) {
      tickets = savedTicket
      tableView.reloadData()
    }
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return tickets.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "My Ticket Cell", for: indexPath) as! MyTicketTableViewCell
    
    cell.updateData(with: tickets[indexPath.row])
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
      let ticketVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TicketVC") as! TicketViewController
      ticketVC.ticket = tickets[indexPath.row]
      ticketVC.isOnlyShowDetailTicket = true
      navigationController?.pushViewController(ticketVC, animated: true)
  }
}
