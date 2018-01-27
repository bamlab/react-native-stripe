// @flow
import React, { Component } from 'react';
import { StyleSheet, Button, View } from 'react-native';

export default class App extends Component<void> {
  goToCustom = () => this.props.navigation.navigate('custom');

  render() {
    return (
      <View style={styles.container}>
        <Button title="Custom card form" onPress={this.goToCustom} />
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
  },
});
