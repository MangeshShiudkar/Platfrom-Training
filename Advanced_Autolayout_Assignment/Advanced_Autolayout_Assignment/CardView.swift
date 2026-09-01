//
//  Assignment 1 — Adaptive Card Grid (STARTER)
//
//  Everything except the Auto Layout is written for you: the card view, the
//  four cards, colours, images, captions and the layout inside each card.
//  Your job is ONLY to write the grid constraints and the trait handling.
//
//  Search for "TODO" — there are two.
//

import UIKit

// MARK: - CardView (provided — do not modify)

/// A single card: a coloured background, a white rounded content area holding
/// an image, and a caption beneath it.
final class CardView: UIView {

    let contentArea = UIView()
    let imageView = UIImageView()
    let captionLabel = UILabel()

    init(title: String, imageName: String, background: UIColor) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = background

        contentArea.translatesAutoresizingMaskIntoConstraints = false
        contentArea.backgroundColor = .white
        contentArea.layer.cornerRadius = 8
        contentArea.clipsToBounds = true

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: imageName) ?? UIImage(systemName: "photo")
        imageView.contentMode = .scaleAspectFit

        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        captionLabel.text = title
        captionLabel.textAlignment = .center
        captionLabel.textColor = .white
        captionLabel.font = .preferredFont(forTextStyle: .headline)
        captionLabel.adjustsFontForContentSizeCategory = true

        addSubview(contentArea)
        contentArea.addSubview(imageView)
        addSubview(captionLabel)

        setupInternalConstraints()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    /// Provided — the layout inside a card. Nothing here is part of the
    /// assignment; the grid is.
    private func setupInternalConstraints() {
        // The caption reports its own height and must keep it at every Dynamic
        // Type size, so it hugs vertically. contentArea has no intrinsic size,
        // which leaves it as the view that absorbs whatever height is spare.
        captionLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)

        NSLayoutConstraint.activate([
            contentArea.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            contentArea.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            contentArea.topAnchor.constraint(equalTo: topAnchor, constant: 12),

            imageView.leadingAnchor.constraint(equalTo: contentArea.leadingAnchor, constant: 8),
            imageView.trailingAnchor.constraint(equalTo: contentArea.trailingAnchor, constant: -8),
            imageView.topAnchor.constraint(equalTo: contentArea.topAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: contentArea.bottomAnchor, constant: -8),

            captionLabel.topAnchor.constraint(equalTo: contentArea.bottomAnchor, constant: 8),
            captionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            captionLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            captionLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}


