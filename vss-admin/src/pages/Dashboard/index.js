import React, { useState } from 'react';
import AppStyles from '../../theme/AppStyles';

const Dashboard = () => {

  const classes = AppStyles()

  return (
    <>
      <h1 className={classes.dinFont}>Dashboard</h1>

      <div className={classes.dinFont}>
        TEST DIN Font
      </div>

      <div className={classes.heroLight}>
        TEST Hero Light Font
      </div>

      <div className={classes.hero}>
        TEST Hero Font
      </div>
    </>
  );
}

export default Dashboard;
