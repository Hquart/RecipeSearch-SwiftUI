//
//  SafariView.swift
//  Reciplease2
//
//  Created by Naji Achkar on 22/06/2021.
//

import Foundation
import SwiftUI
import SafariServices
////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Used in RecipeInfoView to display recipe source web page
////////////////////////////////////////////////////////////////////////////////////////////////////////////

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>)
    -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    func updateUIViewController(_ uiViewController: SFSafariViewController,
                                context: UIViewControllerRepresentableContext<SafariView>) {
    }
}




