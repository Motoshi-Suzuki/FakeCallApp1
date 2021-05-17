//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

public struct IdentifyEntitiesResult: IdentifyResult {
    public let entities: [Entity]

    public init(entities: [Entity]) {
        self.entities = entities
    }
}
