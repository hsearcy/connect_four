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

export default class Board extends React.Component {
  render(){
    return (
      <div className="board">
        {this.props.currentState}
      </div>
    )
  }
}

