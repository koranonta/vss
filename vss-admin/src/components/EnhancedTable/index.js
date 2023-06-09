import React, { useState, useEffect } from 'react';
import { makeStyles } from '@material-ui/core/styles';
import Table from '@material-ui/core/Table';
import TableBody from '@material-ui/core/TableBody';
import TableContainer from '@material-ui/core/TableContainer';
import TablePagination from '@material-ui/core/TablePagination';
import _ from 'lodash'
import EnhancedTableHead from './EnhancedTableHead';

const useStyles = makeStyles((theme) => ({
  root:  { width: '100%', },
  table: { minWidth: 750, },
  visuallyHidden: {
    border: 0,
    clip: 'rect(0 0 0 0)',
    height: 1,
    margin: -1,
    overflow: 'hidden',
    padding: 0,
    position: 'absolute',
    top: 20,
    width: 1,
  },
}));

const EnhancedTable = (props) => {
  const {tableName, tableData, headCells, selected, setSelected, children
  ,order, setOrder
  ,orderBy, setOrderBy
  ,page, setPage
  ,rowsPerPage, setRowsPerPage
  } = props

  const classes = useStyles();

  const handleRequestSort = (event, property) => {
    const isAsc = orderBy === property && order === 'asc';
    setOrder(isAsc ? 'desc' : 'asc');
    setOrderBy(property);
  };

  const handleSelectAllClick = (event) => {    
    if (event.target.checked) 
      setSelected(tableData.map((elem) => elem.clientEquipmentId));
    else 
      setSelected([]);
  };

  const handleChangePage = (event, newPage) => setPage(newPage)

  const handleChangeRowsPerPage = (event) => {
    setRowsPerPage(parseInt(event.target.value, 10));
    setPage(0);
  };

  return (
    <div className={classes.root}>
      <fieldset>
        <legend>{tableName}</legend>

        <TableContainer>
          <Table
            className={classes.table}
            aria-labelledby="tableTitle"
            size={'small'}
            aria-label="enhanced table">
            <EnhancedTableHead
              classes={classes}
              headCells={headCells}
              numSelected={selected.length}
              order={order}
              orderBy={orderBy}
              onSelectAllClick={handleSelectAllClick}
              onRequestSort={handleRequestSort}
              rowCount={_.isEmpty(tableData) ? 0 : tableData.length}/>
            <TableBody>
              { children }
            </TableBody>
          </Table>
        </TableContainer>
        <TablePagination
          rowsPerPageOptions={[5, 10, 25]}
          component="div"
          count={_.isEmpty(tableData) ? 0 : tableData.length}
          rowsPerPage={rowsPerPage}
          page={page}
          onChangePage={handleChangePage}
          onChangeRowsPerPage={handleChangeRowsPerPage}/>
        </fieldset>
    </div>
  );
}

export default EnhancedTable
