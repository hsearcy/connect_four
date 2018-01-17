import React from 'react';
import axios from 'axios';
import Board from './board';

class Home extends React.Component {
  constructor () {
    super();

    this.state = {
      boardstate: null,
      password: null,
      player1: null,
      player2: null,
      mode: 1
    };
  }

  componentDidMount() {
    this.startGame();
  }
  
  startGame(){
    axios.get('game/new')
      .then(response => {
        console.log(response.data);
        this.setState({ boardstate: response.data })
      })
      .catch(error => {
        console.error(error);
      });
  }

  render() {
    return (
      <div>
        <h1> Welcome to Connect Four! </h1>
        <div className="game-board">
          <Board currentState={this.state.boardstate}/>
        </div>
        <div className="game-status">
          <div>Turn: {} </div>
        </div>
      </div>
    );
  }
}

export default Home;