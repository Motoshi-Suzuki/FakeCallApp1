//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

/// An Amplify Category stores certain global states, holds references to plugins for the category, and routes method
/// requests to those plugins appropriately.
public protocol Category: class, CategoryTypeable, DefaultLogger {

    // NOTE: `add(plugin:)` and `getPlugin(for key:)` must be implemented in the actual category classes, since they
    // operate on specific plugin types

    /// Removes the plugin registered for `key` from the list of Plugins that implement functionality for this category.
    /// If no plugin has been added for `key`, no action is taken, making this method safe to call multiple times.
    ///
    /// - Parameter key: The key used to `add` the plugin
    func removePlugin(for key: PluginKey)

}
