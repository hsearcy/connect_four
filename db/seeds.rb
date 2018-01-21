Game.delete_all

Game.create! (
  [
    { #p1 move at col 1 should win
      boardstatus: [[ 1, 1, 1, 1, 0, 0 ],[ 2, 2, 2, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ]],
      password: 'a',
      player1: 'houston',
      player2: 'bob',
      mode: 1,
      move: 1,
      winner: 0
    },
    { #p2 move at col 3 should win
      boardstatus: [[ 2, 1, 1, 1, 0, 0 ],[ 2, 2, 2, 1, 1, 1 ],[ 2, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ]],
      password: 'a',
      player1: 'houston',
      player2: 'bob',
      mode: 1,
      move: 2,
      winner: 0
    },
    { #p1 move at col 3 should win
      boardstatus: [[ 1, 2, 2, 1, 0, 0 ],[ 2, 1, 2, 2, 1, 1 ],[ 2, 2, 1, 0, 0, 0 ],[ 1, 1, 2, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ]],
      password: 'a',
      player1: 'houston',
      player2: 'bob',
      mode: 1,
      move: 1,
      winner: 0
    },
    {
      boardstatus: [[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ],[ 0, 0, 0, 0, 0, 0 ]],
      password: 'a',
      player1: 'houston',
      player2: 'bob',
      mode: 1,
      move: 1,
      winner: 0
    }
  ]
)