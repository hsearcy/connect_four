import React from 'react';
import { 
  BrowserRouter as Router,
  Route
} from 'react-router-dom';
import Home from './Home';
import Game from './Game';

const App = (props) => (
  <Router>
    <div>
      <Route
        exact path='/'
        component={Home}
      />
      <Route
        path='/play/:mode'
        component={Game}
      />
      <Route
        path='/play/:mode/:id'
        component={Game}
      />
    </div>
  </Router>
)

export default App