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
    })
      .then(res => {
        console.log(res);
        return fetch('http://localhost:3000/', {
          method: 'POST',
          headers: {
            Accept: 'application/json, text/plain, */*',
            'Content-Type': 'application/json',
          },
          body: JSON.stringify({ token: res.tokenId }),
        });
      })
      .then(cards => console.log('cards', cards));
  }
}

export default new Localstripe();
