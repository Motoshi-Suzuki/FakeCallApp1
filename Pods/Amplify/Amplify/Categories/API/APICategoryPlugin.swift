//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

public protocol APICategoryPlugin: Plugin, APICategoryBehavior { }

public extension APICategoryPlugin {
    var categoryType: CategoryType {
        return .api
    }
}
