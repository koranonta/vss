import React from 'react';
import App from './App';
import ReactDOM from 'react-dom';
import '../node_modules/bulma/css/bulma.min.css';
import './assets/css/btn.css'

//import { createRoot } from 'react-dom/client';
//const container = document.getElementById('root');
//const root = createRoot(container);
import { AppProvider } from './context/AppContext';

ReactDOM.render(
  <AppProvider>
      <App />
  </AppProvider>,
document.getElementById('root')
);

/*
root.render(
  <AppProvider>
    <App />
  </AppProvider>
  
);
*/

