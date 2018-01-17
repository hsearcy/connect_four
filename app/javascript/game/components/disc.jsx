import React from 'react';

export default class Disc extends React.Component {
  render() {
    return (
      <div className={`disc ${this.props.marker}`}></div>
    );
  }
}