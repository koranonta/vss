import {colors} from '../util/Colors'

const tableRow = {
  fontFamily: 'hero', 
  height: '50px', 
  verticalAlign: 'middle',
  whiteSpace: 'nowrap',
}

const tableHeader = {
  backgroundColor: colors.yellowBackground, 
  color: colors.darkBrown, 
  fontFamily: "heroLight", 
  textTransform: 'uppercase',
  whiteSpace: 'nowrap',
}

const filterOption = {
  border: '0', 
  backgroundColor: colors.yellowBackground, 
  color: colors.darkBrown, 
  fontFamily: "hero",  
}

const orderSummary = {
  ...tableRow,
  fontSize: '12px',
  paddingLeft: '10px',
  textAlign: 'center',
  marginTop: '-5px',
}

const badge = {
  boxSizing: 'border-box',
  display: 'inline-block',
  color: '#ffffff',
  textAlign: 'center',
  lineHeight: 'inherit',
  width: '25px',
  height: '25px',
  borderRadius: '50%',
}


const circle = {
  display: 'inlineTable',
  verticalAlign: 'middle',
  width: '40px',
  height: '40px',
  backgroundColor: '#bbb',
  borderRadius: '50%',
}

const circleContent = {
  display: 'tableCell',
  verticalAlign: 'middle',
  textAlign: 'bottom',
}

const orderItemHeader = {
  padding: '5px', 
  fontFamily: 'heroLight', 
  fontSize: '0.8rem',
}

const inputLabel = {
  marginTop: '3px', 
  marginRight: '15px', 
  fontFamily: 'heroLight'  
}

export const commonStyles = {
  tableRow,
  tableHeader, 
  filterOption,
  orderSummary,
  badge,
  circle,
  circleContent,
  orderItemHeader,
  inputLabel,   
}
