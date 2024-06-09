//
//  Information.swift
//  JorgeMeds
//
//  Created by Mateus Andreatta on 08/06/24.
//

import Foundation
import FirebaseFirestore

struct Information: Codable {
    @DocumentID var id: String?
    var allergies: [String]
}
