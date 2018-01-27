// @flow
import React, { PureComponent } from 'react';
import { StyleSheet, View, Modal, Button, TouchableOpacity, Text } from 'react-native';
import { CreditCardInput } from 'react-native-credit-card-input';
import { compose, withState, withProps } from 'recompose';

type Props = {
  openCardModal: () => any,
  closeCardModal: () => any,
  isCardModalOpened: boolean,
};

const CloseButton = props => (
  <TouchableOpacity onPress={props.onPress} activeOpacity={0.7} style={styles.closeButton}>
    <Text style={styles.closeButtonText}>X</Text>
  </TouchableOpacity>
);

class Manual extends PureComponent<Props> {
  render() {
    return (
      <View style={styles.container}>
        <Button title="Add a card" onPress={this.props.openCardModal} />
        <Modal
          visible={this.props.isCardModalOpened}
          onRequestClose={this.closeCardModal}
          animationType="slide"
        >
          <View style={styles.modal}>
            <CloseButton onPress={this.props.closeCardModal} />
            <CreditCardInput onChange={this.props.onCardEdit} />
            <Button title="Add Card" onPress={this.props.addCard} />
          </View>
        </Modal>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  modal: {},
  closeButton: {
    paddingHorizontal: 20,
    paddingVertical: 30,
  },
  closeButtonText: {
    fontSize: 22,
    fontWeight: 'bold',
  },
});

export default compose(
  withState('isCardModalOpened', 'setIsCardModalOpened', false),
  withState('creditCard', 'onCardEdit', null),
  withProps(({ setIsCardModalOpened }) => ({
    openCardModal: () => setIsCardModalOpened(true),
    closeCardModal: () => setIsCardModalOpened(false),
    addCard: () => {
      setIsCardModalOpened(false);
    },
  }))
)(Manual);
