//
//  ViewController.swift
//  SettingApp
//
//  Created by Mangesh Shiudkar on 28/08/26.
//

import UIKit

class ViewController: UIViewController {
        
    // Using typealias to make Diffable Data Source easier to use
    typealias DataSource = UICollectionViewDiffableDataSource<UUID, UUID>
    typealias Snapshot = NSDiffableDataSourceSnapshot<UUID, UUID>
        
    // Main collection view to display all settings sections and items
    private var collectionView: UICollectionView!
    
    // Diffable data source to manage collection view data
    private var dataSource: DataSource!
    
    // Search controller to search settings items
    private let searchController = UISearchController(
        searchResultsController: nil
    )
    
    // Main data for all settings sections
    private var sections: [SettingsSection] = [
        SettingsSection(
            title: "Account",
            items: []
        ),
        SettingsSection(
            title: "General",
            items: [
                SettingsItem(
                    title: "General",
                    icon: "gearshape.fill",
                    iconColorName: "gray"
                ),
                SettingsItem(
                    title: "Accessibility",
                    icon: "accessibility",
                    iconColorName: "blue"
                ),
                SettingsItem(
                    title: "Action Button",
                    icon: "arrow.turn.down.right",
                    iconColorName: "blue"
                ),
                SettingsItem(
                    title: "Apple Intelligence & Siri",
                    icon: "sparkles",
                    iconColorName: "pink"
                ),
                SettingsItem(
                    title: "Camera",
                    icon: "camera.fill",
                    iconColorName: "gray"
                ),
                SettingsItem(
                    title: "Home Screen & App Library",
                    icon: "apps.iphone",
                    iconColorName: "blue"
                ),
                SettingsItem(
                    title: "Search",
                    icon: "magnifyingglass",
                    iconColorName: "gray"
                ),
                SettingsItem(
                    title: "StandBy",
                    icon: "rectangle.portrait.and.arrow.forward",
                    iconColorName: "gray"
                )
            ]
        ),
        SettingsSection(
            title: "Screen Time",
            items: [
                SettingsItem(
                    title: "Screen Time",
                    icon: "hourglass",
                    iconColorName: "purple"
                )
            ]
        ),
        SettingsSection(
            title: "Privacy & Security",
            items: [
                SettingsItem(
                    title: "Privacy & Security",
                    icon: "hand.raised.fill",
                    iconColorName: "blue"
                )
            ]
        )
    ]
    
    // This property returns sections based on search text
    private var displayedSections: [SettingsSection] {
        let searchText = searchController.searchBar.text?
            .trimmingCharacters(
                in: .whitespacesAndNewlines
            ) ?? ""
        
        // If search text is empty, return all sections
        guard !searchText.isEmpty else {
            return sections
        }
        
        // Filter items based on search text
        return sections.compactMap { section in
            let matchingItems = section.items.filter {
                $0.title.localizedCaseInsensitiveContains(
                    searchText
                )
            }
            
            // If no matching item is found, do not show that section
            guard !matchingItems.isEmpty else {
                return nil
            }
            
            // Create filtered section with matching items
            var filteredSection = section
            filteredSection.items = matchingItems
            
            // Keep filtered section expanded to show search results
            filteredSection.isExpanded = true
            
            return filteredSection
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup all UI and collection view
        setupView()
        setupNavigationBar()
        setupSearchController()
        setupCollectionView()
        
        // Configure data source and show initial data
        configureDataSource()
        applySnapshot(
            animatingDifferences: false
        )
    }
    
    override func viewWillAppear(
        _ animated: Bool
    ) {
        super.viewWillAppear(animated)
        
        // Enable large title for Settings screen
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Set custom font for large title
        navigationController?.navigationBar.largeTitleTextAttributes = [
            .font: UIFont.systemFont(
                ofSize: 38,
                weight: .bold
            )
        ]
    }
        
    private func setupView() {
        // Set background color for Settings screen
        view.backgroundColor = .systemGroupedBackground
        
        // Set navigation title
        title = "Settings"
        
        // Always show large navigation title
        navigationItem.largeTitleDisplayMode = .always
    }
        
    private func setupNavigationBar() {
        // Add plus button to add a new section
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "plus"
            ),
            style: .plain,
            target: self,
            action: #selector(
                addSectionTapped
            )
        )
    }
        
    private func setupSearchController() {
        // Update search results when user types
        searchController.searchResultsUpdater = self
        
        // Do not hide collection view while searching
        searchController.obscuresBackgroundDuringPresentation = false
        
        // Set search bar placeholder
        searchController.searchBar.placeholder = "Search"
        
        // Add search controller to navigation bar
        navigationItem.searchController = searchController
        
        // Keep search bar visible while scrolling
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // Make sure search controller is presented correctly
        definesPresentationContext = true
    }
        
    private func setupCollectionView() {
        // Create collection view using compositional layout
        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        
        collectionView.backgroundColor =
            .systemGroupedBackground
        
        collectionView.translatesAutoresizingMaskIntoConstraints =
        false
        
        // Add collection view to main view
        view.addSubview(
            collectionView
        )
        
        // Set collection view constraints
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(
                equalTo:
                    view.safeAreaLayoutGuide.topAnchor
            ),
            
            collectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            
            collectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            
            collectionView.bottomAnchor.constraint(
                equalTo: view.bottomAnchor
            )
        ])
        
        // Register cell for settings items
        collectionView.register(
            SettingsCell.self,
            forCellWithReuseIdentifier:
                SettingsCell.identifier
        )
        
        // Register header for normal settings sections
        collectionView.register(
            SettingsHeaderView.self,
            forSupplementaryViewOfKind:
                UICollectionView.elementKindSectionHeader,
            withReuseIdentifier:
                SettingsHeaderView.identifier
        )
        
        // Register custom header for Account section
        collectionView.register(
            AccountHeaderView.self,
            forSupplementaryViewOfKind:
                UICollectionView.elementKindSectionHeader,
            withReuseIdentifier:
                AccountHeaderView.identifier
        )
    }
        
    private func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout {
            [weak self] sectionIndex, environment in
            
            guard let self = self else {
                return nil
            }
            
            // Get current section
            let section =
            self.displayedSections[sectionIndex]
            
            // MARK: - Account Section Layout
            
            // Create different layout for Account section
            if section.title == "Account" {
                
                // Create invisible item because Account section
                // only uses custom header
                let itemSize =
                NSCollectionLayoutSize(
                    widthDimension:
                            .fractionalWidth(1),
                    heightDimension:
                            .absolute(1)
                )
                
                let item =
                NSCollectionLayoutItem(
                    layoutSize: itemSize
                )
                
                let groupSize =
                NSCollectionLayoutSize(
                    widthDimension:
                            .fractionalWidth(1),
                    heightDimension:
                            .absolute(1)
                )
                
                let group =
                NSCollectionLayoutGroup.vertical(
                    layoutSize: groupSize,
                    subitems: [item]
                )
                
                let layoutSection =
                NSCollectionLayoutSection(
                    group: group
                )
                
                // Set spacing around Account section
                layoutSection.contentInsets =
                NSDirectionalEdgeInsets(
                    top: 0,
                    leading: 16,
                    bottom: 20,
                    trailing: 16
                )
                
                // Set custom Account header height
                let headerSize =
                NSCollectionLayoutSize(
                    widthDimension:
                            .fractionalWidth(1),
                    heightDimension:
                            .absolute(120)
                )
                
                // Create header for Account section
                let header =
                NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerSize,
                    elementKind:
                        UICollectionView
                        .elementKindSectionHeader,
                    alignment: .top
                )
                
                layoutSection.boundarySupplementaryItems = [
                    header
                ]
                
                return layoutSection
            }
            
            
            // Set size for each settings item
            let itemSize =
            NSCollectionLayoutSize(
                widthDimension:
                        .fractionalWidth(1),
                heightDimension:
                        .absolute(62)
            )
            
            let item =
            NSCollectionLayoutItem(
                layoutSize: itemSize
            )
            
            // Create vertical group for settings items
            let groupSize =
            NSCollectionLayoutSize(
                widthDimension:
                        .fractionalWidth(1),
                heightDimension:
                        .estimated(62)
            )
            
            let group =
            NSCollectionLayoutGroup.vertical(
                layoutSize: groupSize,
                subitems: [item]
            )
            
            let layoutSection =
            NSCollectionLayoutSection(
                group: group
            )
            
            // Set spacing around normal sections
            layoutSection.contentInsets =
            NSDirectionalEdgeInsets(
                top: 0,
                leading: 16,
                bottom: 20,
                trailing: 16
            )
            
            // Set normal section header height
            let headerSize =
            NSCollectionLayoutSize(
                widthDimension:
                        .fractionalWidth(1),
                heightDimension:
                        .absolute(58)
            )
            
            // Create header for normal sections
            let header =
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind:
                    UICollectionView
                    .elementKindSectionHeader,
                alignment: .top
            )
            
            layoutSection.boundarySupplementaryItems = [
                header
            ]
            
            return layoutSection
        }
    }
        
    private func createSectionLayout(
        isEmpty: Bool
    ) -> NSCollectionLayoutSection {
        
        // Create item size
        let itemSize =
        NSCollectionLayoutSize(
            widthDimension:
                    .fractionalWidth(1),
            heightDimension:
                    .absolute(62)
        )
        
        let item =
        NSCollectionLayoutItem(
            layoutSize: itemSize
        )
        
        // Create group for items
        let groupSize =
        NSCollectionLayoutSize(
            widthDimension:
                    .fractionalWidth(1),
            heightDimension:
                    .estimated(62)
        )
        
        let group =
        NSCollectionLayoutGroup.vertical(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section =
        NSCollectionLayoutSection(
            group: group
        )
        
        // Set section spacing
        section.contentInsets =
        NSDirectionalEdgeInsets(
            top: 0,
            leading: 16,
            bottom: 20,
            trailing: 16
        )
        
        // Create section header
        let headerSize =
        NSCollectionLayoutSize(
            widthDimension:
                    .fractionalWidth(1),
            heightDimension:
                    .absolute(58)
        )
        
        let header =
        NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind:
                UICollectionView
                .elementKindSectionHeader,
            alignment: .top
        )
        
        section.boundarySupplementaryItems = [
            header
        ]
        
        return section
    }
        
    private func configureDataSource() {
        // Configure data source for collection view
        dataSource =
        UICollectionViewDiffableDataSource<UUID, UUID>(
            collectionView: collectionView
        ) {
            [weak self]
            collectionView,
            indexPath,
            itemID in
            
            guard let self = self else {
                return nil
            }
            
            // Get item using item ID
            guard let item =
                    self.item(for: itemID)
            else {
                return nil
            }
            
            // Create settings cell
            guard let cell =
                    collectionView.dequeueReusableCell(
                        withReuseIdentifier:
                            SettingsCell.identifier,
                        for: indexPath
                    ) as? SettingsCell
            else {
                return nil
            }
            
            // Get current snapshot
            let snapshot =
            self.dataSource.snapshot()
            
            let sectionIDs =
            snapshot.sectionIdentifiers
            
            // Check section index is valid
            guard indexPath.section <
                    sectionIDs.count
            else {
                return cell
            }
            
            let sectionID =
            sectionIDs[indexPath.section]
            
            // Get all items for current section
            let itemsInSection =
            self.displayedSections.first {
                $0.id == sectionID
            }?.items ?? []
            
            // Check if current item is last item
            let isLastItem =
            itemsInSection.last?.id == item.id
            
            // Configure cell with item data
            cell.configure(
                item: item,
                isLastItem: isLastItem
            )
            
            // Delete item when delete button is tapped
            cell.onDeleteTapped = {
                [weak self] in
                
                self?.deleteItem(
                    itemID
                )
            }
            
            return cell
        }
        
        // Configure section headers
        configureSupplementaryViews()
    }
        
    private func configureSupplementaryViews() {
        // Configure headers for all sections
        dataSource.supplementaryViewProvider = {
            [weak self]
            collectionView,
            kind,
            indexPath in
            
            guard let self = self,
                  kind ==
                    UICollectionView
                .elementKindSectionHeader
            else {
                return nil
            }
            
            // Get current snapshot
            let snapshot =
            self.dataSource.snapshot()
            
            // Check section index is valid
            guard indexPath.section <
                    snapshot.sectionIdentifiers.count
            else {
                return nil
            }
            
            let sectionID =
            snapshot.sectionIdentifiers[
                indexPath.section
            ]
            
            // Get section using section ID
            guard let section =
                    self.section(
                        for: sectionID
                    )
            else {
                return nil
            }
                        
            // Use custom header for Account section
            if section.title == "Account" {
                let accountHeader =
                collectionView
                    .dequeueReusableSupplementaryView(
                        ofKind: kind,
                        withReuseIdentifier:
                            AccountHeaderView.identifier,
                        for: indexPath
                    ) as! AccountHeaderView
                
                return accountHeader
            }
                        
            // Use normal header for other sections
            let header =
            collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier:
                        SettingsHeaderView.identifier,
                    for: indexPath
                ) as! SettingsHeaderView
            
            // Configure section title and expanded state
            header.configure(
                title: section.title,
                isExpanded: section.isExpanded
            )
            
            // Expand or collapse section
            header.onExpandTapped = {
                [weak self] in
                
                self?.toggleSection(
                    sectionID
                )
            }
            
            // Show alert to add new item
            header.onAddTapped = {
                [weak self] in
                
                self?.showAddItemAlert(
                    sectionID: sectionID
                )
            }
            
            // Show alert before deleting section
            header.onDeleteTapped = {
                [weak self] in
                
                self?.showDeleteSectionAlert(
                    sectionID: sectionID
                )
            }
            
            return header
        }
    }
        
    private func applySnapshot(
        animatingDifferences: Bool = true
    ) {
        // Create new snapshot
        var snapshot = Snapshot()
        
        // Get sections which need to display
        let sectionsToDisplay =
        displayedSections
        
        // Get IDs of all sections
        let sectionIDs =
        sectionsToDisplay.map {
            $0.id
        }
        
        // Add sections to snapshot
        snapshot.appendSections(
            sectionIDs
        )
        
        // Add items for each section
        for section in sectionsToDisplay {
            let itemIDs: [UUID]
            
            // Show items only when section is expanded
            if section.isExpanded {
                itemIDs =
                section.items.map {
                    $0.id
                }
            } else {
                itemIDs = []
            }
            
            snapshot.appendItems(
                itemIDs,
                toSection: section.id
            )
        }
        
        // Apply updated snapshot to collection view
        dataSource.apply(
            snapshot,
            animatingDifferences:
                animatingDifferences
        )
    }
        
    // Find section using section ID
    private func section(
        for sectionID: UUID
    ) -> SettingsSection? {
        
        sections.first {
            $0.id == sectionID
        }
    }
    
    // Find item by searching in all sections
    private func item(
        for itemID: UUID
    ) -> SettingsItem? {
        
        for section in sections {
            if let item =
                section.items.first(
                    where: {
                        $0.id == itemID
                    }
                ) {
                
                return item
            }
        }
        
        return nil
    }
        
    private func toggleSection(
        _ sectionID: UUID
    ) {
        // Find selected section
        guard let index =
                sections.firstIndex(
                    where: {
                        $0.id == sectionID
                    }
                )
        else {
            return
        }
        
        // Change expanded state
        sections[index].isExpanded.toggle()
        
        // Update collection view
        applySnapshot()
    }
        
    @objc private func addSectionTapped() {
        // Create alert to add new section
        let alert =
        UIAlertController(
            title: "Add Section",
            message:
                "Enter the section name.",
            preferredStyle: .alert
        )
        
        // Add text field for section name
        alert.addTextField {
            textField in
            
            textField.placeholder =
            "Section name"
        }
        
        // Add cancel action
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        
        // Add new section
        alert.addAction(
            UIAlertAction(
                title: "Add",
                style: .default
            ) {
                [weak self] _ in
                
                // Get entered section title
                guard let self = self,
                      let title =
                        alert.textFields?
                    .first?
                    .text?
                    .trimmingCharacters(
                        in:
                                .whitespacesAndNewlines
                    ),
                      !title.isEmpty
                else {
                    return
                }
                
                // Create new empty section
                let newSection =
                SettingsSection(
                    title: title,
                    items: []
                )
                
                // Add section to data
                self.sections.append(
                    newSection
                )
                
                // Update collection view
                self.applySnapshot()
            }
        )
        
        present(
            alert,
            animated: true
        )
    }
        
    private func showAddItemAlert(
        sectionID: UUID
    ) {
        // Create alert to add new item
        let alert =
        UIAlertController(
            title: "Add Item",
            message:
                "Enter the item name.",
            preferredStyle: .alert
        )
        
        // Add text field for item name
        alert.addTextField {
            textField in
            
            textField.placeholder =
            "Item name"
        }
        
        // Add cancel action
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        
        // Add new item
        alert.addAction(
            UIAlertAction(
                title: "Add",
                style: .default
            ) {
                [weak self] _ in
                
                // Get entered item title and selected section
                guard let self = self,
                      let title =
                        alert.textFields?
                    .first?
                    .text?
                    .trimmingCharacters(
                        in:
                                .whitespacesAndNewlines
                    ),
                      !title.isEmpty,
                      let index =
                        self.sections.firstIndex(
                            where: {
                                $0.id == sectionID
                            }
                        )
                else {
                    return
                }
                
                // Create new settings item
                let newItem =
                SettingsItem(
                    title: title,
                    icon: "gearshape.fill",
                    iconColorName: "blue"
                )
                
                // Add item to selected section
                self.sections[index]
                    .items
                    .append(
                        newItem
                    )
                
                // Keep section expanded after adding item
                self.sections[index]
                    .isExpanded = true
                
                // Update collection view
                self.applySnapshot()
            }
        )
        
        present(
            alert,
            animated: true
        )
    }
        
    private func deleteItem(
        _ itemID: UUID
    ) {
        // Search item in all sections
        for sectionIndex in sections.indices {
            if let itemIndex =
                sections[sectionIndex]
                .items
                .firstIndex(
                    where: {
                        $0.id == itemID
                    }
                ) {
                
                // Remove selected item
                sections[sectionIndex]
                    .items
                    .remove(
                        at: itemIndex
                    )
                
                // Update collection view
                applySnapshot()
                
                return
            }
        }
    }
        
    private func showDeleteSectionAlert(
        sectionID: UUID
    ) {
        // Get section which needs to delete
        guard let section =
                self.section(
                    for: sectionID
                )
        else {
            return
        }
        
        // Create confirmation alert
        let alert =
        UIAlertController(
            title: "Delete \(section.title)?",
            message:
                "This will delete the section and all its items.",
            preferredStyle: .alert
        )
        
        // Add cancel action
        alert.addAction(
            UIAlertAction(
                title: "Cancel",
                style: .cancel
            )
        )
        
        // Delete selected section
        alert.addAction(
            UIAlertAction(
                title: "Delete",
                style: .destructive
            ) {
                [weak self] _ in
                
                guard let self = self else {
                    return
                }
                
                // Remove section and all its items
                self.sections.removeAll {
                    $0.id == sectionID
                }
                
                // Update collection view
                self.applySnapshot()
            }
        )
        
        present(
            alert,
            animated: true
        )
    }
    
}

// Search
extension ViewController:
    UISearchResultsUpdating {
    
    
    func updateSearchResults(
        for searchController:
        UISearchController
    ) {
        // Update collection view when search text changes
        applySnapshot()
    }
    
}
