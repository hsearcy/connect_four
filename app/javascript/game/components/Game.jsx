import React from 'react';
import axios from 'axios';
import Board from './board';
import { Link } from 'react-router-dom';

axios.defaults.headers.post['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
class Game extends React.Component {
  constructor (props) {
    super();

    this.state = {
      id: null,
      boardstatus: null,
      password: null,
      player1: null,
      player2: null,
      mode: props.match.params.mode,
      move: null,
      winner: null
    };
  }

  componentDidMount() {
    this.startGame();
  }
  
  startGame(){
    axios.get('/game/new')
      .then(response => {
        console.log(response.data);
        let gamestate = response.data;
        this.setState({ 
          id: gamestate.id,
          boardstatus: gamestate.boardstatus,
          move: gamestate.move,
          winner: gamestate.winner
         });
      })
      .catch(error => {
        console.error(error);
      });
  }

  handleClick(col) {
    if (this.state.winner) return;
    axios.post('/game/move', {
      id: this.state.id,
      moveCol: col
    })
    .then(response => {
      let gamestate = response.data;
      this.setState({
        boardstatus: gamestate.boardstatus,
        move: gamestate.move,
        winner: gamestate.winner
      })
      console.log(response);
    })
    .catch(error => {
      console.error(error);
    })
  }

  winner() {
    if (this.state.winner) {
      return (
        <div className='winner'> Winner - Player {this.state.winner} </div>
      );
    }
  }

  render() {
    if(!this.state.boardstatus) {
      return <div>wait pls.</div>
    }

    return (
      <div>
        <h1> Welcome to Connect Four! </h1>
        <div className="game-board">
          <Board
            boardstatus={this.state.boardstatus}
            onClick={col => this.handleClick(col)}
          />
          {this.winner()}
        </div>
        <div className="game-status">
          <div>Turn - Player {this.state.move} </div>
        </div>
        <div onClick={() => this.startGame()}>
          <h2>Start Over?</h2>
        </div>
        
      </div>
    );
  }
}

export default Game;