import React, { useState } from 'react';
import AppStyles from '../../theme/AppStyles';

const Dashboard = () => {

  const classes = AppStyles()

  return (
    <>
      <h1 className={classes.dinFont}>Dashboard</h1>
    </>
  );
}

export default Dashboard;
