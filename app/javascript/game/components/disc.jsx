import React from 'react';

export default class Disc extends React.Component {
  render() {
    return (
      <button className={`disc ${this.props.marker}`} onClick={this.props.onClick}></button>
    );
  }
}