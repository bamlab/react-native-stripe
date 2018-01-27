using ReactNative.Bridge;
using System;
using System.Collections.Generic;
using Windows.ApplicationModel.Core;
using Windows.UI.Core;

namespace Stripe.RNStripe
{
    /// <summary>
    /// A module that allows JS to share data.
    /// </summary>
    class RNStripeModule : NativeModuleBase
    {
        /// <summary>
        /// Instantiates the <see cref="RNStripeModule"/>.
        /// </summary>
        internal RNStripeModule()
        {

        }

        /// <summary>
        /// The name of the native module.
        /// </summary>
        public override string Name
        {
            get
            {
                return "RNStripe";
            }
        }
    }
}
