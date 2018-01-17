import React from 'react';
import axios from 'axios';
import Board from './board';

axios.defaults.headers.post['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
class Home extends React.Component {
  constructor () {
    super();

    this.state = {
      id: null,
      boardstatus: null,
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
        this.setState({ 
          id: response.data.id,
          boardstatus: response.data.boardstatus,
          mode: response.data.mode
         })
      })
      .catch(error => {
        console.error(error);
      });
  }

  handleClick(col) {
    axios.post('game/move', {
      id: this.state.id,
      moveCol: col
    })
    .then(response => {
      console.log(response);
    })
    .catch(error => {
      console.error(error);
    })
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
        </div>
        <div className="game-status">
          <div>Turn: {} </div>
        </div>
      </div>
    );
  }
}

export default Home;