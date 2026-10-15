//
//  ViewController.swift
//  ConstraintsDemo
//
//  Assignment 3 — Diagnose & Fix. Menu listing the five broken screens so each
//  one can be opened, run and inspected in the view debugger on its own.

import UIKit

final class ViewController: UITableViewController {

    private struct Screen {
        let title: String
        let intended: String
        let make: () -> UIViewController
    }

    private let screens: [Screen] = [
        Screen(title: "Screen 1 — Banner",
               intended: "200 pt red banner, centred label. Check the console.",
               make: { Screen1ViewController() }),
        Screen(title: "Screen 2 — Row",
               intended: "Value always readable in full; the name gives way when space is tight.",
               make: { Screen2ViewController() }),
        Screen(title: "Screen 3 — Scroll",
               intended: "Six 180 pt blocks scrolling vertically.",
               make: { Screen3ViewController() }),
        Screen(title: "Screen 4 — Table",
               intended: "Cells that grow to fit their text.",
               make: { Screen4ViewController() }),
        Screen(title: "Screen 5 — Header",
               intended: "A table header as tall as its wrapping text needs.",
               make: { Screen5ViewController() }),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Assignment 3"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        screens.count
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let screen = screens[indexPath.row]
        cell.textLabel?.text = screen.title
        cell.detailTextLabel?.text = screen.intended
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(screens[indexPath.row].make(), animated: true)
    }
}
