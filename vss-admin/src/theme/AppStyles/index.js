import { makeStyles } from '@material-ui/core/styles';
import { colors } from '../../util/Colors'
const AppStyles = makeStyles((theme) => ({ 
  tableFont: { fontSize: '12px' },

  dialogHeader: {
    fontFamily: 'din',
    fontSize: '30px',
    flexGrow: 1,
  },

  inputArea: {
    height: '6em', 
    marginBottom: '7px', 
    padding: '1px'
  },

  inputNumber: {
    padding: '5px',
    height: '30px',
    border: 'none',
    borderBottom: '1px solid black',
    borderRadius: '0',
    backgroundColor: colors.yellowBackground, 
  },

  selectOption: {
    height: '30px',
    width:'100%',
    border: 'none',
    borderBottom: '1px solid black',
    borderRadius: '0',
    paddingLeft: '10px',
  },

  inputText: {
    height: '30px',
    border: 'none',
    borderRadius: '0',
    fontFamily: 'hero',
    borderBottom: '1px solid black',
    backgroundColor: colors.yellowBackground, 
  },

  pillButton: {
    backgroundColor: colors.darkBrown,
    border: 'none',
    color: colors.white,
    padding: '5px 5px',
    textAlign: 'center',
    margin: '4px 2px',
    cursor: 'pointer',
    borderRadius: '16px',
  },

  pillButtonPale: {
    backgroundColor: colors.paleBrown,
    border: 'none',
    color: colors.white,
    padding: '5px 5px',
    textAlign: 'center',
    margin: '4px 2px',
    cursor: 'pointer',
    borderRadius: '16px',
  },


  underLine: {
    borderBottom: '1px solid black',
    marginRight: '7rem',
  },


   modalFooter: {
    paddingTop: '0.3rem',
  },

  rightButtonPanel: {
    paddingTop: '0.3rem',
    display: 'flex',
    justifyContent: 'flex-end'
  },

  dinFont: {
    fontFamily: "din"
  },

  heroLight: {
    fontFamily: "heroLight"
  },

  hero: {
    fontFamily: "hero"
  },

  tableCell: {
    fontFamily: 'hero',
    height: '80px',
    textAlign: 'center',
    verticalAlign: 'middle' ,    
  },

  title: {
    fontFamily: "din",
    fontSize: 40,
    fontWeight: 900,
  },

  filterLabel: {
    color: colors.darkBrown, 
    verticalAlign: 'middle', 
    fontFamily: 'heroLight',
    fontSize: 18,
  },

  filterOptions: {
    color: colors.darkBrown, 
    verticalAlign: 'middle', 
    marginLeft: '1em', 
    borderBottom: `2px solid ${colors.darkBrown}`
  },

  tableHeader: {
    fontFamily: 'heroLight',
    backgroundColor: colors.yellowBackground, 
    color: colors.darkBrown,
    textTransform: 'uppercase',
  },

  tableRow: {
    fontFamily: 'hero', 
    height: '50px', 
    verticalAlign: 'middle',
  },

  rightJustifyContainer: {
    display: 'flex', 
    justifyContent: 'flex-end', 
    marginTop:'1rem'
  },

  orderDetailHeader: {
    fontFamily: 'din',
    fontSize: '30px',
    flexGrow: 1,
  },

  orderLabel: {
    fontFamily: 'heroLight',
  },

  orderHeader: {
    fontFamily: 'hero',
  },

  orderStatusLabel: {
    fontFamily: 'din',
    textTransform: 'uppercase',
  },
  orderStatusValue: {
    fontFamily: 'din',
    fontSize: '20px',
    color: colors.greenText,
    textTransform: 'uppercase',
  },

  orderTableHeader: {
    backgroundColor: colors.palePink,
  },

  orderItemDetail: {
    fontFamily: 'heroLight',
  },

  orderSummaryContainer: {
     backgroundColor: colors.palePink, 
     borderRadius: '.5em', 
     padding: '3rem'
  },

  subTotal: {
    fontFamily: 'heroLight',
  },

  total: {
    fontFamily: 'hero',
    textTransform: 'uppercase',
  },

  inputLabel: {
    marginTop: '3px', 
    marginRight: '15px', 
    fontFamily: 'heroLight',
  },

  themeBackground: {
    backgroundColor: colors.yellowBackground, 
  }


}));


export default AppStyles