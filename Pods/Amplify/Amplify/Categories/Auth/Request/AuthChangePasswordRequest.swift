//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Foundation

public struct AuthChangePasswordRequest: AmplifyOperationRequest {

    public let oldPassword: String

    public let newPassword: String

    public var options: Options

    public init(oldPassword: String,
                newPassword: String,
                options: Options) {
        self.oldPassword = oldPassword
        self.newPassword = newPassword
        self.options = options
    }
}

public extension AuthChangePasswordRequest {

    struct Options {

        // TODO: Move this metadata to plugin options. All other request has the metadata
        // inside the plugin options.

        public let metadata: [String: String]?

        public init(metadata: [String: String]? = nil) {
            self.metadata = metadata
        }
    }
}
