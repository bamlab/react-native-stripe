
# react-native-stripe

Basic Stripe integration with React Native.

The project just started, feel free to contribute.

## Getting started

`$ npm install react-native-stripe --save`

### Installation

#### iOS

1. Settup cocoapod if not done yet.
2. Add in your podfile, the following lines :
```
  pod 'react-native-stripe', path: '../../..'
  pod 'yoga', path: '../node_modules/react-native/ReactCommon/yoga/yoga.podspec'
  pod 'React', :path => '../node_modules/react-native', :subspecs => [
    'Core',
    'RCTActionSheet',
    'RCTAnimation',
    'RCTGeolocation',
    'RCTImage',
    'RCTLinkingIOS',
    'RCTNetwork',
    'RCTSettings',
    'RCTText',
    'RCTVibration',
    'RCTWebSocket',
    'DevSupport'
  ]
```
3. Run `pod install` in your `ios/` folder.


#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.reactlibrary.RNStripePackage;` to the imports at the top of the file
  - Add `new RNStripePackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-stripe'
  	project(':react-native-stripe').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-stripe/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-stripe')
  	```

## Usage
```javascript
import Stripe from 'react-native-stripe';

Stripe.init({
  publishableKey: 'pk_...',
});

Stripe.createTokenWithCard({
    number: '4111 1111 1111 1111',
    cvc: '123',
    expMonth: 11,
    expYear: 22,
}).then(res => {
  console.log(res.token);
});
```
  
