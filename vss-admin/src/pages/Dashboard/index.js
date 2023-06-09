import React, { useState } from 'react';

import countries from '../../data/countries.json';
import Countries from '../../components/Countries';
import AppStyles from '../../theme/AppStyles';

const Dashboard = () => {
  const [data] = useState(countries);
  const [itemsPerPage, setItemsPerPage] = useState(10)

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

      <div className={`container px-2`}>
      <Countries 
          data={data} 
          itemsPerPage={itemsPerPage} 
          setItemsPerPage={setItemsPerPage}
          searchByData={[
            { label: 'Search by country', value: 'name' },
            { label: 'Search by capital', value: 'capital' },
            { label: 'Search by country code', value: 'iso2' },
            { label: 'Search by currency', value: 'currency' },
            { label: 'Search by phone code', value: 'phone_code' }
          ]} 
        />

      </div>


    </>
  );
}

export default Dashboard;
