import React from 'react';
import App from './App';
import '../node_modules/bulma/css/bulma.min.css';
import './assets/css/btn.css'

import { createRoot } from 'react-dom/client';
const container = document.getElementById('root');
const root = createRoot(container);
root.render(
  <App />
);


