import React from 'react';
import axios from 'axios';
import Board from './board';
import { Link } from 'react-router-dom';

axios.defaults.headers.post['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
export default class Game extends React.Component {
  constructor (props) {
    super();

    this.state = {
      id: props.match.params.id,
      boardstatus: null,
      password: null,
      player1: null,
      player2: null,
      mode: props.match.params.mode,
      move: null,
      winner: null,
      thinking: null
    };
  }

  componentDidMount() {
    this.startGame();
  }
  
  startGame(reset = false){
    axios.post('/game/new/', {
      mode: this.state.mode,
      id: this.state.id,
      reset: reset
    })
      .then(response => {
        let gamestate = response.data;
        this.setState({ 
          id: gamestate.id,
          boardstatus: gamestate.boardstatus,
          mode: gamestate.mode,
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
    this.doMove(col);
  }

  doMove(col) {
    axios.post('/game/move', {
      id: this.state.id,
      moveCol: col
    })
    .then(response => {
      this.updateGameState(response.data);
      if (this.state.mode === 3 && this.state.move === 2 && this.state.winner === 0){
        this.setState({
          thinking: true
        });
        this.getComputerMove();
      }
    })
    .catch(error => {
      console.error(error);
    });
  }

  getComputerMove() {
    axios.post('/game/computer/move', {
      id: this.state.id
    })
    .then(response => {
      this.updateGameState(response.data);
    })
    .catch(error => {
      console.error(error);
    });
  }

  updateGameState(gamestate) {
    this.setState({
      boardstatus: gamestate.boardstatus,
      move: gamestate.move,
      winner: gamestate.winner,
      thinking: false
    });
  }

  winner() {
    if (this.state.winner) {
      return (
        <h1 className='winner'> Winner - Player {this.state.winner} </h1>
      );
    }
  }

  thinking() {
    if (this.state.thinking) {
      return (
        <h1 className='thinking'> Computer is thinking... </h1>
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
          {this.thinking()}
        </div>
        <div className="game-status">
          <div>Turn - Player {this.state.move} </div>
          <div>Game ID (for loading): {this.state.id} </div>
        </div>
        <div >
          <button onClick={() => this.startGame(true)}>
            Start Over?
          </button>
        </div>
        <Link to='/'><button>Go Home</button></Link>
        
      </div>
    );
  }
}

