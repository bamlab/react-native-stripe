
# react-native-stripe

Basic Stripe integration with React Native.

The project just started, feel free to contribute.

## Getting started

`$ npm install react-native-stripe --save`

### Mostly automatic installation

`$ react-native link react-native-stripe`

### Manual installation


#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-stripe` and add `RNStripe.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNStripe.a` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. Run your project (`Cmd+R`)<

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
import RNStripe from 'react-native-stripe';

// TODO: What to do with the module?
RNStripe;
```
  
