//
//  SettingsSection.swift
//  SettingApp
//
//  Created by Mangesh Shiudkar on 28/08/26.
//

import Foundation

struct SettingsSection {

    let id: UUID
    var title: String
    var items: [SettingsItem]
    var isExpanded: Bool

    init(
        id: UUID = UUID(),
        title: String,
        items: [SettingsItem],
        isExpanded: Bool = true
    ) {
        self.id = id
        self.title = title
        self.items = items
        self.isExpanded = isExpanded
    }
}
