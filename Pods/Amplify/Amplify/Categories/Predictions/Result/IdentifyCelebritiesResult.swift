//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

public struct IdentifyCelebritiesResult: IdentifyResult {
    public let celebrities: [Celebrity]

    public init(celebrities: [Celebrity]) {
        self.celebrities = celebrities
    }
}
