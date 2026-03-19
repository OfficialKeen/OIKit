//
//  String.swift
//  OIKit
//
//  Created by Keen on 19/03/26.
//

import Foundation

extension String {
    var hexToUInt32: UInt32? {
        var hex = self.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hex.hasPrefix("#") { hex.removeFirst() }
        guard hex.count == 6 else { return nil }
        return UInt32(hex, radix: 16)
    }
}
