//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

public struct IdentifyDocumentTextResult: IdentifyResult {

    public let fullText: String
    public let words: [IdentifiedWord]
    public let rawLineText: [String]
    public let identifiedLines: [IdentifiedLine]
    public let selections: [Selection]
    public let tables: [Table]
    public let keyValues: [BoundedKeyValue]

    public init(fullText: String,
                words: [IdentifiedWord],
                rawLineText: [String],
                identifiedLines: [IdentifiedLine],
                selections: [Selection],
                tables: [Table],
                keyValues: [BoundedKeyValue]) {

        self.fullText = fullText
        self.words = words
        self.rawLineText = rawLineText
        self.identifiedLines = identifiedLines
        self.selections = selections
        self.tables = tables
        self.keyValues = keyValues
    }
}
