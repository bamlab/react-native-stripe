import Stripe from 'react-native-stripe';
import { NativeModules } from 'react-native';

class Localstripe {
  constructor() {
    Stripe.init({
      publishableKey: 'pk_test_U8hFcpNT2bX5HzZajlPdZ0ja',
    });
  }

  addCard(card) {
    const { number, expiry, cvc } = card.values;
    const [expMonth, expYear] = expiry.split('/').map(val => Number(val));
    Stripe.createTokenWithCard({
      number,
      cvc,
      expMonth,
      expYear,
    }).then(res => console.log(res));
  }
}

export default new Localstripe();
