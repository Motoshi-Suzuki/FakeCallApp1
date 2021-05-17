//
// Copyright Amazon.com Inc. or its affiliates.
// All Rights Reserved.
//
// SPDX-License-Identifier: Apache-2.0
//

import Amplify
import AWSMobileClient

extension SignInResult {

    func toAmplifyAuthSignInStep() throws -> AuthSignInStep {
        switch signInState {
        case .signedIn:
            return .done
        case .smsMFA:
            let deliveryDetails = AuthCodeDeliveryDetails(destination: .sms(codeDetails?.destination))
            return .confirmSignInWithSMSMFACode(deliveryDetails, nil)
        case .customChallenge:
            return .confirmSignInWithCustomChallenge(nil)
        case .newPasswordRequired:
            return .confirmSignInWithNewPassword(nil)
        default:
            throw (AuthError.unknown("AWSMobileClient auth state is not handled"))
        }
    }
}
