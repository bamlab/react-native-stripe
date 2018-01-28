
package com.reactlibrary;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.Arguments;

import com.facebook.react.bridge.ReadableMap;
import com.facebook.react.bridge.WritableMap;

import com.stripe.android.Stripe;
import com.stripe.android.model.Card;
import com.stripe.android.TokenCallback;
import com.stripe.android.model.Token;


public class RNStripeModule extends ReactContextBaseJavaModule {
  private static final String TAG = "com.reactlibrary.stripe";
  private final ReactApplicationContext reactContext;
  private Stripe stripe;

  public RNStripeModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @ReactMethod
  public void init(ReadableMap options) {
    String publicKey = options.getString("publishableKey");
    stripe = new Stripe(reactContext.getBaseContext(), publicKey);
  }

 @ReactMethod
 public void createTokenWithCard(final ReadableMap card, final Promise promise) {
   try {
     stripe.createToken(createCard(card),
         new TokenCallback() {
           public void onSuccess(Token token) {
             promise.resolve(convertTokenToWritableMap(token));
           }

           public void onError(Exception error) {
             error.printStackTrace();
             promise.reject(TAG, error.getMessage());
           }
         });
   } catch (Exception e) {
     promise.reject(TAG, e.getMessage());
   }
 }

  @Override
  public String getName() {
    return "RNStripe";
  }

  private WritableMap convertTokenToWritableMap(Token token) {
    WritableMap newToken = Arguments.createMap();

    if (token == null) return newToken;

    newToken.putString("tokenId", token.getId());
    newToken.putBoolean("livemode", token.getLivemode());
    newToken.putBoolean("used", token.getUsed());
    newToken.putDouble("created", token.getCreated().getTime());

    if (token.getCard() != null) {
      newToken.putMap("card", convertCardToWritableMap(token.getCard()));
    }
    return newToken;
  }

  private Card createCard(final ReadableMap cardData) {
    return new Card(
        // required fields
        cardData.getString("number"),
        cardData.getInt("expMonth"),
        cardData.getInt("expYear"),
        // additional fields
        getIfExist(cardData, "cvc"),
        getIfExist(cardData, "name"),
        getIfExist(getMapIfExist(cardData, "address"), "line1"),
        getIfExist(getMapIfExist(cardData,"address"), "line2"),
        getIfExist(getMapIfExist(cardData,"address"), "city"),
        getIfExist(getMapIfExist(cardData,"address"), "state"),
        getIfExist(getMapIfExist(cardData,"address"), "zip"),
        getIfExist(getMapIfExist(cardData,"address"), "postalCode"),
        getIfExist(cardData, "brand"),
        getIfExist(cardData, "last4"),
        getIfExist(cardData, "fingerprint"),
        getIfExist(cardData, "funding"),
        getIfExist(cardData, "country"),
        getIfExist(cardData, "currency"),
        getIfExist(cardData, "id")
    );
  }
  private WritableMap convertCardToWritableMap(final Card card) {
    WritableMap result = Arguments.createMap();

    if(card == null) return result;

    result.putString("cardId", card.getId());
    result.putString("number", card.getNumber());
    result.putString("cvc", card.getCVC() );
    result.putInt("expMonth", card.getExpMonth() );
    result.putInt("expYear", card.getExpYear() );
    result.putString("name", card.getName() );
    result.putString("addressLine1", card.getAddressLine1() );
    result.putString("addressLine2", card.getAddressLine2() );
    result.putString("addressCity", card.getAddressCity() );
    result.putString("addressState", card.getAddressState() );
    result.putString("addressZip", card.getAddressZip() );
    result.putString("addressCountry", card.getAddressCountry() );
    result.putString("last4", card.getLast4() );
    result.putString("brand", card.getBrand() );
    result.putString("funding", card.getFunding() );
    result.putString("fingerprint", card.getFingerprint() );
    result.putString("country", card.getCountry() );
    result.putString("currency", card.getCurrency() );

    return result;
  }

  private String getIfExist(final ReadableMap map, final String key) {
    if (map == null || !map.hasKey(key)) {
      return null;
    }
    return map.getString(key);
  }

  private ReadableMap getMapIfExist(final ReadableMap map, final String key) {
    if (map == null || !map.hasKey(key)) {
      return null;
    }
    return map.getMap(key);
  }

}
