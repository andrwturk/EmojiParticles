//
//  String+Emoji.swift
//  ParticlesBackground
//
//  Created by Andrew Turkin on 15.04.18.
//  Copyright © 2018 Andrew Trukin. All rights reserved.
//

import Foundation

extension Character {
    var unicodeScalarCodePoint: Int {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        return Int(scalars[scalars.startIndex].value)
    }
}

extension String {
    var emojis:[Character] {
        let emojiRanges = [0x1F601...0x1F64F, 0x2702...0x27B0, 0x1F389...0x1F390]
        let emojiSet = Set(emojiRanges.joined())
        return self.filter { emojiSet.contains($0.unicodeScalarCodePoint) }
    }
}
