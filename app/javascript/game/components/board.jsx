// export default class Board {
//   constructor() {
//     this.grid = [
//       [ 0, 0, 0, 0, 0, 0 ],
//       [ 0, 0, 0, 0, 0, 0 ],
//       [ 0, 0, 0, 0, 0, 0 ],
//       [ 0, 0, 0, 0, 0, 0 ],
//       [ 0, 0, 0, 0, 0, 0 ],
//       [ 0, 0, 0, 0, 0, 0 ],
//       [ 0, 0, 0, 0, 0, 0 ]
//     ];
//   }
// }
import React from 'react';
import Disc from './disc';

export default class Board extends React.Component {

  getDiscs(column, col_index) {
    return column.map( (disc, row_index) => {
      return <Disc 
        marker={disc}
        id={String(col_index) + String(row_index)}
        key={String(col_index) + String(row_index)}
        row={row_index}
        col={col_index}
        onClick={() => this.props.onClick(col_index)}
      />
    })
  }


  renderBoard() {
    return this.props.boardstatus.map( (col, col_index) => {
      return this.getDiscs(col, col_index)
    })
  }
  
  render(){
    return (
      <div className="board">
        {this.renderBoard()}
      </div>
    )
  }
}

