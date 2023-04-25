//
//  Profile.swift
//  Landmarks
//
//  Created by Edho Guntur Adhitama on 25/04/23.
//

import Foundation

struct Profile {
    var username: String
    var preferNotofications = true
    var seasonalPhoto = Season.winter
    var goalDate = Date()
    
    static let `default` =  Profile(username: "edhoguntur")
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"

        var id: String { rawValue }
    }
    
}
