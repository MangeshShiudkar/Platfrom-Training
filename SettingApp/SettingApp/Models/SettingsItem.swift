//
//  SettingsItem.swift
//  SettingApp
//
//  Created by Mangesh Shiudkar on 28/08/26.
//

import Foundation

struct SettingsItem: Hashable {

    let id: UUID
    var title: String
    var icon: String
    var iconColorName: String

    init(
        id: UUID = UUID(),
        title: String,
        icon: String,
        iconColorName: String = "blue"
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.iconColorName = iconColorName
    }
}
