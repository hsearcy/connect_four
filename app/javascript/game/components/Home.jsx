import React from 'react';
import { Link } from 'react-router-dom';

class Home extends React.Component {

  render() {
    return (
      <div>
        <h1> Welcome to Connect Four!</h1>
        <div>
          <h2>Want to play a new 2 player game?</h2>
          <Link to={'/play/1'}>Play a 2 player game!</Link>
        </div>
        <div>
          <h2>Want to play a new game against Bob (easy)?</h2>
          <Link to={'/play/2'}>Play a game against Bob!</Link>
        </div>
        <div>
          <h2>Want to play a new game against Alice (hard)?</h2>
          <Link to={'/play/3'}>Play a game against Alice!</Link>
        </div>
        <div>
          <h2>Have a Game ID from an ongoing game and want to continue?</h2>
          Enter game ID:
        </div>
      </div>
    );
  }
}

export default Home;