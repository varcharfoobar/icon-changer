//
//  SwiftUIView.swift
//  Bubbles
//
//  Created by Berk Dogan on 28/5/2023.
//
//
//  ChangeAppIconViewModel.swift
//  Infinity
//
//  Created by Berk Dogan on 16/4/2023.
//
// All sorted, thanks to --> https://www.avanderlee.com/swift/alternate-app-icon-configuration-in-xcode/

import Foundation
import SwiftUI

final class ChangeAppIconViewModel: ObservableObject {
    enum AppIcon: String, CaseIterable, Identifiable {
        case primary = "AppIcon"
        case appIcon2 = "AppIcon-2"

        var id: String { rawValue }
        var iconName: String? {
            switch self {
            case .primary:
                /// `nil` is used to reset the app icon back to its primary icon.
                return nil
            default:
                return rawValue
            }
        }

        // Description of the icons
        var description: String {
            switch self {
            case .primary:
                return "Light"
            case .appIcon2:
                return "Dark"
            }
        }

        var preview: UIImage {
            UIImage(named: rawValue) ?? UIImage()
        }
    }

    @Published private(set) var selectedAppIcon: AppIcon

    init() {
        if let iconName = UIApplication.shared.alternateIconName, let appIcon = AppIcon(rawValue: iconName) {
            selectedAppIcon = appIcon
        } else {
            selectedAppIcon = .primary
        }
    }

    func updateAppIcon(to icon: AppIcon) {
        let previousAppIcon = selectedAppIcon
        selectedAppIcon = icon

        Task { @MainActor in
            guard UIApplication.shared.alternateIconName != icon.iconName else {
                /// No need to update since we're already using this icon.
                return
            }

            do {
                try await UIApplication.shared.setAlternateIconName(icon.iconName)
            } catch {
                /// We're only logging the error here and not actively handling the app icon failure
                /// since it's very unlikely to fail.
                print("Updating icon to \(String(describing: icon.iconName)) failed.")

                /// Restore previous app icon
                selectedAppIcon = previousAppIcon
            }
        }
    }
}
