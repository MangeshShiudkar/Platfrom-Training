//  Assignment 2 — Profile Header Row (STARTER)
//  All four views, their styling and three content variants are provided.
//  Your job is ONLY to fill in setupConstraints(), setupCHCR() and  setupPriorities(). Search for "TODO" — there are three.

import UIKit

final class ProfileHeaderViewController: UIViewController {

    // MARK: - Provided views

    private let avatarView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.image = UIImage(systemName: "person.crop.circle.fill")
        iv.tintColor = .systemGray3
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 32          // half of the 64 pt size you'll set
        return iv
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private let actionButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Edit Profile"
        config.baseBackgroundColor = .systemGreen
        config.baseForegroundColor = .white
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 8, leading: 16, bottom: 8, trailing: 16)
        config.background.cornerRadius = 8
        config.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = .preferredFont(forTextStyle: .subheadline)
                return outgoing
            }

        let button = UIButton(configuration: config)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - Provided sample content

    /// Change this to 0, 1 and 2 or add any other text variants to show the constraint priority and CHCR in action.
    private let variant = 0

    private let variants: [(title: String, subtitle: String)] = [
        ("Jhonson King", "jhonking@gmail.com"),
        ("Bartholomew Fitzgerald-Montgomery III", "bart@gmail.com"),
        ("Ana Silva", "ana.silva.very.long.address.for.testing@somelongdomainname.co.uk"),
    ]

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        [avatarView, titleLabel, subtitleLabel, actionButton]
            .forEach(view.addSubview)

        applyVariant(variant)
        setupConstraints()
        setupCHCR()
        setupPriorities()
    }

    private func applyVariant(_ index: Int) {
        titleLabel.text = variants[index].title
        subtitleLabel.text = variants[index].subtitle
    }

    // MARK: - Your work
    // Preferred vertical spacing constraints.
    // These are stored so I can give them lower priority.
    private var preferredTitleBottom: NSLayoutConstraint!
    private var preferredSubtitleTop: NSLayoutConstraint!
    
    // Preferred 32 pt horizontal padding constraints.
    // These can reduce when there is not enough space.
    private var preferredAvatarLeading: NSLayoutConstraint!
    private var preferredButtonTrailing: NSLayoutConstraint!
    
    private func setupConstraints() {
        let guide = view.safeAreaLayoutGuide
        
        // Preferred vertical position for title,subtitile.
        // It can adjust when the content needs more space.
        preferredTitleBottom = titleLabel.bottomAnchor.constraint(equalTo: avatarView.centerYAnchor, constant: -2)
        preferredSubtitleTop = subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
        
        // Prefer 32 pt leading and trailing padding when enough space is available.
        preferredAvatarLeading = avatarView.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 32)
        preferredButtonTrailing = actionButton.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -32)
        
        NSLayoutConstraint.activate([
            
            // Avatar View
            
            // Avatar: 64 pt width with height based on width to keep it square.
            preferredAvatarLeading,
            avatarView.leadingAnchor.constraint(greaterThanOrEqualTo: guide.leadingAnchor, constant: 16),
            avatarView.centerYAnchor.constraint(equalTo: guide.centerYAnchor),
            avatarView.widthAnchor.constraint(equalToConstant: 64),
            avatarView.heightAnchor.constraint(equalTo: avatarView.widthAnchor),
            
            // Action Button
            
            // Button: prefers 32 pt trailing padding but never goes below 16 pt.
            preferredButtonTrailing,
            actionButton.trailingAnchor.constraint(lessThanOrEqualTo: guide.trailingAnchor, constant: -16),
            actionButton.centerYAnchor.constraint(equalTo: avatarView.centerYAnchor),
            
            // Title Label
            
            // Labels stay between the avatar and button without overlapping.
            titleLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -12),
            subtitleLabel.leadingAnchor.constraint(equalTo: avatarView.trailingAnchor, constant: 12),
            subtitleLabel.trailingAnchor.constraint(lessThanOrEqualTo: actionButton.leadingAnchor, constant: -12),
            
            // Preferred vertical spacing constraints.
            preferredTitleBottom,
            preferredSubtitleTop,
            
            // Make sure title/subtitle stays inside the safe area.
            titleLabel.topAnchor.constraint(greaterThanOrEqualTo: guide.topAnchor, constant: 8),
            subtitleLabel.bottomAnchor.constraint(lessThanOrEqualTo: guide.bottomAnchor, constant: -8),
        ])
    }

    private func setupCHCR() {
        
        // Button keeps its content first, while title and subtitle can compress
        // when horizontal space is limited.
        actionButton.setContentCompressionResistancePriority(.required, for: .horizontal)
        actionButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        subtitleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        
        titleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        subtitleLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)

        titleLabel.numberOfLines = 1
        subtitleLabel.numberOfLines = 1
        titleLabel.lineBreakMode = .byTruncatingTail
        subtitleLabel.lineBreakMode = .byTruncatingTail
    }

    private func setupPriorities() {
        
        // These are preferred constraints, so they can adjust
        // when the available space is limited.
        preferredTitleBottom.priority = .defaultHigh
        preferredSubtitleTop.priority = .defaultHigh
        preferredAvatarLeading.priority = .defaultHigh
        preferredButtonTrailing.priority = .defaultHigh
    }
}
