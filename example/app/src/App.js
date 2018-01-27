// @flow
import React, { Component } from 'react';
import { StackNavigator } from 'react-navigation';
import Home from './Home';
import Custom from './Custom';

export default StackNavigator(
  {
    home: {
      screen: Home,
      navigationOptions: {
        header: null,
      },
    },
    custom: {
      screen: Custom,
      navigationOptions: {
        title: 'Add Card',
      },
    },
  },
  {
    initialRoute: 'home',
  }
);
