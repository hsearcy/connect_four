import React from 'react';

export default class Disc extends React.Component {
  render() {
    return (
      <div className={`cell ${this.props.marker}`}></div>
    );
  }
}