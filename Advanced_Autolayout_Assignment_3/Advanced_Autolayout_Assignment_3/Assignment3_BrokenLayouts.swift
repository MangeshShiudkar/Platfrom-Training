//
//  Screen1ViewController.swift
//  Advanced_Autolayout_Assignment_3
//
//  Created by Mangesh Shiudkar on 01/09/26.
//


//
//  Assignment 3 — Diagnose & Fix (STARTER)
//
//  Five screens. Each one is BROKEN in exactly one way. The header comment on
//  each screen describes the layout that was INTENDED — it does not tell you
//  what is wrong. Your job is to find the fault, fix it, and write up the
//  diagnosis.
//
//  Do not rewrite a screen from scratch. Find the minimal correct fix.
//
//  Run each screen, read the console, and use the view debugger.
//

import UIKit

// =====================================================================
// MARK: - Screen 1
//
//  INTENDED: A red banner across the top of the safe area, 200 pts tall,
//  with a label centred inside it.
//
//  SYMPTOM: Check the console.
// =====================================================================

final class Screen1ViewController: UIViewController {

    private let banner = UIView()
    private let label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Screen 1"

        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = .systemRed
        view.addSubview(banner)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Banner"
        label.textColor = .white
        banner.addSubview(label)

        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            banner.topAnchor.constraint(equalTo: guide.topAnchor),
            banner.heightAnchor.constraint(equalToConstant: 200),
            // Banner height fixed at 200. Here used bottom constraint
            // saying bottom = top + 120. That's a conflict — height already
            // says bottom should be top + 200, so both can't be true at once.
            // Removed the bottom constraint since the banner just needs a fixed height.
//            banner.bottomAnchor.constraint(equalTo: guide.topAnchor, constant: 120),

            label.centerXAnchor.constraint(equalTo: banner.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: banner.centerYAnchor),
        ])
    }
}

// =====================================================================
// MARK: - Screen 2
//
//  INTENDED: One row holding two labels — a name on the left and its
//  value on the right — filling the width of the safe area. The value is
//  short and must always be readable in full. When the name is too long
//  to fit alongside it, the name is the one that gives way.
//
//  SYMPTOM: The value is crushed away to nothing and never appears on
//  screen, while the name keeps as much of its own text as it can. The
//  console says nothing at all.
// =====================================================================

final class Screen2ViewController: UIViewController {

    private let nameLabel = UILabel()
    private let valueLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Screen 2"

        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.text = "Name is a very lengthy text made to be lengthy and very lengthy"
        nameLabel.font = .preferredFont(forTextStyle: .body)
        nameLabel.backgroundColor = .systemTeal        // makes the frame visible
        view.addSubview(nameLabel)

        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.text = "Value"
        valueLabel.font = .preferredFont(forTextStyle: .body)
        valueLabel.textAlignment = .right
        valueLabel.backgroundColor = .systemOrange     // makes the frame visible
        view.addSubview(valueLabel)
        
        // Both the name label and value label need horizontal space.
        // When the name text is very long, there may not be enough space
        // for both labels to display their full intrinsic content size.
        // In this screen, the value label is short and should always remain visible.
        // Therefore, the name label should be compressed before the
        // value label when horizontal space is limited.
        // Fixing this by making valueLabel required (never shrink) and nameLabel
        // low priority (shrink first). Now name gives up space, value stays full.
        nameLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        valueLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: guide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 16),

            valueLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            valueLabel.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -16),
        ])
    }
}

// =====================================================================
// MARK: - Screen 3
//
//  INTENDED: A vertically scrolling column of six coloured blocks, each
//  180 pts tall, scrolling smoothly from the first to the last.
//
//  SYMPTOM: It does not scroll.
// =====================================================================

final class Screen3ViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Screen 3"

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        let colours: [UIColor] = [.systemRed, .systemOrange, .systemYellow,
                                  .systemGreen, .systemBlue, .systemPurple]
        var previous: UIView?

        for colour in colours {
            let block = UIView()
            block.translatesAutoresizingMaskIntoConstraints = false
            block.backgroundColor = colour
            contentView.addSubview(block)

            NSLayoutConstraint.activate([
                block.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                block.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                block.heightAnchor.constraint(equalToConstant: 180),
                block.topAnchor.constraint(
                    equalTo: previous?.bottomAnchor ?? contentView.topAnchor),
            ])
            previous = block
        }
        
        // last block was not connected to contentView's bottom that's why
        // the scroll view didn't know how tall the content actually is
        if let last = previous {
            last.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        }

        let frameGuide = scrollView.frameLayoutGuide
        let contentGuide = scrollView.contentLayoutGuide

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // was set to frameGuide before that's wrong, content should
            // set to contentGuide so scroll view knows the real content size
            contentView.topAnchor.constraint(equalTo: contentGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: contentGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: contentGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: contentGuide.bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: frameGuide.widthAnchor),
        ])
    }
}

// =====================================================================
// MARK: - Screen 4
//
//  INTENDED: A table view whose cells grow to fit their text — one-line
//  rows stay short, paragraph rows become tall.
//
//  SYMPTOM: Every row is the same height and the text is clipped.
// =====================================================================

final class Screen4ViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView()

    private let rows: [String] = [
        "Short row.",
        "A somewhat longer row that should wrap onto two lines when displayed.",
        "A much longer row. Auto Layout resolves a system of constraints to determine the size and position of every view. When a cell is self-sizing, the same mechanism decides the row height from the cell's own constraints, which is why an unbroken chain from top to bottom matters so much.",
        "Short again.",
        "Another long one. Content hugging and compression resistance decide which view stretches and which one truncates when the available space does not match the intrinsic content size of everything in the row.",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Screen 4"
        view.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(BodyCell.self, forCellReuseIdentifier: "BodyCell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            // Deliberate: the table is pinned to the raw view edges, not the safe area,
            // so the list scrolls under the navigation bar. This is not the fault.
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BodyCell",
                                                 for: indexPath) as! BodyCell
        cell.bodyLabel.text = rows[indexPath.row]
        return cell
    }
}

final class BodyCell: UITableViewCell {

    let bodyLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.numberOfLines = 0
        bodyLabel.font = .preferredFont(forTextStyle: .body)
        contentView.addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            // This bottom constraint was missing before. Without it there was no
            // unbroken chain from the top of the cell to the bottom, so the cell
            // couldn't measure its own real height — it just fell back to a fixed
            // default height for every row, which is why they all looked the same
            // and the longer text got cut off. Adding this bottom constraint lets each
            // cell size itself based on how much text it actually has.
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

// =====================================================================
// MARK: - Screen 5
//
//  INTENDED: A table with a header above the rows carrying a title and a
//  wrapping description, the header standing exactly as tall as that
//  text needs. The rows themselves are already correct.
//
//  SYMPTOM: The header is not there. The rows start at the top of the
//  table as though no header had been set at all.
// =====================================================================

final class Screen5ViewController: UIViewController, UITableViewDataSource {

    private let tableView = UITableView()
    private let header = UIView()

    private let rows: [String] = [
        "Constraints", "Priorities", "Layout guides",
        "Size classes", "Self-sizing cells",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Screen 5"

        buildHeader()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    // Here rather than in viewDidLoad: the table has no width until it has been
    // laid out, and measuring against a width of zero gives a meaningless
    // height for text that wraps.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sizeHeaderToFit()
    }

    private func sizeHeaderToFit() {

        // Get the current width of the table view.
        let targetWidth = tableView.bounds.width

        // Set the header width before calculating its required height.
        header.frame = CGRect(x: 0, y: 0, width: targetWidth, height: 0)

        // Calculate the required height based on the Auto Layout constraints
        // and the wrapping content of the labels.
        let size = header.systemLayoutSizeFitting(
            CGSize(
                width: targetWidth,
                height: UIView.layoutFittingCompressedSize.height
            ),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        // Update the header height with the calculated height.
        header.frame.size.height = size.height

        // Assign the header to the table view only when it is not already assigned
        // or when its size has changed.
        if tableView.tableHeaderView !== header ||
            tableView.tableHeaderView?.frame.size != header.frame.size {
            tableView.tableHeaderView = header
        }
    }

    // The header's own subviews are constrained top to bottom, exactly as they
    // would be in a cell.
    private func buildHeader() {
        header.backgroundColor = .secondarySystemBackground

        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "Layout notes"
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        header.addSubview(titleLabel)

        let bodyLabel = UILabel()
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        bodyLabel.numberOfLines = 0
        bodyLabel.font = .preferredFont(forTextStyle: .subheadline)
        bodyLabel.textColor = .secondaryLabel
        bodyLabel.text = "Each row below names a topic from the training material. "
            + "This description wraps onto several lines, so the header cannot "
            + "have one fixed height that is right on every device."
        header.addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: header.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -16),
        ])
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rows.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rows[indexPath.row]
        return cell
    }
}
