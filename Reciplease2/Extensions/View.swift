//
//  View.swift
//  Reciplease2
//
//  Created by Naji Achkar on 25/04/2021.
//


import SwiftUI
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/// EXTENSIONS
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// no modifier available to hide keyboard(), so we have to use this extension for the moment:
#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
extension URLComponents {
    // This func will map [String: String] parameters to URLQueryItems
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//extension Bundle {
//    func decode<T: Codable>(_ file: String) -> T {
//        guard let url = self.url(forResource: file, withExtension: nil) else {
//            fatalError("Failed to locate \(file) in bundle.")
//        }
//
//        guard let data = try? Data(contentsOf: url) else {
//            fatalError("Failed to load \(file) from bundle.")
//        }
//
//        let decoder = JSONDecoder()
//
//        let formatter = DateFormatter()
//        formatter.dateFormat = "y-MM-dd"
//        decoder.dateDecodingStrategy = .formatted(formatter)
//
//        guard let loaded = try? decoder.decode(T.self, from: data) else {
//            fatalError("Failed to decode \(file) from bundle.")
//        }
//        return loaded
//    }
//}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Additionnal custom colors:
extension Color {
    static let appGreen = Color("appGreen")
    static let appGray = Color("appGray")
    static let titleFontColor = Color("titleFontColor")
    static let appBrown = Color("appBrown")
    static let appRed = Color("appRed")
    static let appBackground = Color("appBackground")
    static let appDarkGrey = Color("appDarkGrey")
    static let appYellow = Color("appYellow")
    static let appLightGrey = Color("appLightGrey")
}


