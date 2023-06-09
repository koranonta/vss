import React, {forwardRef, useState, useEffect, useImperativeHandle, useRef} from 'react';
import PropTypes from 'prop-types';
import SvgIcon from '@material-ui/core/SvgIcon';
import { makeStyles, withStyles } from '@material-ui/core/styles';
import TreeView from '@material-ui/lab/TreeView';
import TreeItem from '@material-ui/lab/TreeItem';
import Collapse from '@material-ui/core/Collapse';
import { useSpring, animated } from '@react-spring/web'; // web.cjs is required for IE 11 support
import _ from 'lodash'
function MinusSquare(props) {

  return (
    <SvgIcon fontSize="inherit" style={{ width: 12, height: 12 }} {...props}>
      {/* tslint:disable-next-line: max-line-length */}
      <path d="M22.047 22.074v0 0-20.147 0h-20.12v0 20.147 0h20.12zM22.047 24h-20.12q-.803 0-1.365-.562t-.562-1.365v-20.147q0-.776.562-1.351t1.365-.575h20.147q.776 0 1.351.575t.575 1.351v20.147q0 .803-.575 1.365t-1.378.562v0zM17.873 11.023h-11.826q-.375 0-.669.281t-.294.682v0q0 .401.294 .682t.669.281h11.826q.375 0 .669-.281t.294-.682v0q0-.401-.294-.682t-.669-.281z" />
    </SvgIcon>
  );
}

function PlusSquare(props) {
  return (
    <SvgIcon fontSize="inherit" style={{ width: 12, height: 12 }} {...props}>
      {/* tslint:disable-next-line: max-line-length */}
      <path d="M22.047 22.074v0 0-20.147 0h-20.12v0 20.147 0h20.12zM22.047 24h-20.12q-.803 0-1.365-.562t-.562-1.365v-20.147q0-.776.562-1.351t1.365-.575h20.147q.776 0 1.351.575t.575 1.351v20.147q0 .803-.575 1.365t-1.378.562v0zM17.873 12.977h-4.923v4.896q0 .401-.281.682t-.682.281v0q-.375 0-.669-.281t-.294-.682v-4.896h-4.923q-.401 0-.682-.294t-.281-.669v0q0-.401.281-.682t.682-.281h4.923v-4.896q0-.401.294-.682t.669-.281v0q.401 0 .682.281t.281.682v4.896h4.923q.401 0 .682.281t.281.682v0q0 .375-.281.669t-.682.294z" />
    </SvgIcon>
  );
}

function CloseSquare(props) {
  return (
    <SvgIcon className="close" fontSize="inherit" style={{ width: 12, height: 12 }} {...props}>
      {/* tslint:disable-next-line: max-line-length */}
      <path d="M17.485 17.512q-.281.281-.682.281t-.696-.268l-4.12-4.147-4.12 4.147q-.294.268-.696.268t-.682-.281-.281-.682.294-.669l4.12-4.147-4.12-4.147q-.294-.268-.294-.669t.281-.682.682-.281.696 .268l4.12 4.147 4.12-4.147q.294-.268.696-.268t.682.281 .281.669-.294.682l-4.12 4.147 4.12 4.147q.294.268 .294.669t-.281.682zM22.047 22.074v0 0-20.147 0h-20.12v0 20.147 0h20.12zM22.047 24h-20.12q-.803 0-1.365-.562t-.562-1.365v-20.147q0-.776.562-1.351t1.365-.575h20.147q.776 0 1.351.575t.575 1.351v20.147q0 .803-.575 1.365t-1.378.562v0z" />
    </SvgIcon>
  );
}

function TransitionComponent(props) {
  const style = useSpring({
    from: { opacity: 0, transform: 'translate3d(20px,0,0)' },
    to: { opacity: props.in ? 1 : 0, transform: `translate3d(${props.in ? 0 : 20}px,0,0)` },
  });

  return (
    <animated.div style={style}>
      <Collapse {...props} />
    </animated.div>
  );
}

TransitionComponent.propTypes = {
  /**
   * Show the component; triggers the enter or exit states
   */
  in: PropTypes.bool,
};

const StyledTreeItem = withStyles((theme) => ({
  iconContainer: {
    '& .close': {
      opacity: 0.3,
    },
  },
  group: {
    marginLeft: 7,
    paddingLeft: 18,
    borderLeft: `1px dashed `,
  },
  label: {
    fontSize: '12px',
  },
  root: {
    "&.Mui-selected > .MuiTreeItem-content": {
      
      backgroundColor: "#D2F4F3"
    }
  }
}))((props) => <TreeItem {...props} TransitionComponent={TransitionComponent} />);

const useStyles = makeStyles({
  root: {
    height: 264,
    flexGrow: 1,
    maxWidth: 400,
  },
});

const CustomizedTreeView = forwardRef((props, ref) => {
  const {data, handleClick} = props
  const [expanded, setExpanded] = useState([]);
  const [selected, setSelected] = useState([]);

  const classes = useStyles();

  useEffect(() => {
    setExpanded(['root'])
    setSelected('root')
  }, [])

  const handleToggle = (event, nodeIds) => {
    setExpanded(nodeIds);
    console.log("In handleToggle", nodeIds);
    //handleClick(event, nodeIds)
  };

  const handleSelect = (event, nodeIds) => {
    setSelected(nodeIds);
    console.log("In handleSelect", nodeIds);
    //handleClick(event, nodeIds)
  };  

  const expandNode = (id) => {
    console.log("in expandNode", id)
    setExpanded(id)
    const lastElem = id[id.length - 1]
    console.log (lastElem)
    setSelected([lastElem])
  }

  const handleLabelClick = (e, nodes) => {
    console.log("In handleLabelClick", nodes)
    handleClick(e, nodes)
  }

  const handleIconClick = (e, nodes) => {
    //e.preventDefault()
    console.log("In handleIconClick ", nodes)
    handleClick(e, nodes)
    //handleToggle(e, nodes)
  }

  const renderTree = (nodes) => {
    if (_.isEmpty(nodes)) return ""
    return (
      <StyledTreeItem key={nodes.key || nodes.id} 
                      nodeId={nodes.id} 
                      label={nodes.title} 
                      onLabelClick={(e) => handleLabelClick(e, nodes)} 
                      onIconClick={(e) => handleIconClick(e, nodes)}
                      classes={{label: classes.label}}>
        {Array.isArray(nodes.children) ? nodes.children.map((node) => renderTree(node)) : null}
      </StyledTreeItem>
    )
  }  
/*
  const treeRef = useRef(null);
    useImperativeHandle(ref, () => ({
      expandNode: (nodeId) => {
        console.log("In expand node")
        expandNode(nodeId)
      }
      //expandNode: (nodeId) => treeRef.current?.setExpanded(nodeId)
  }));
*/
  return (
    <TreeView
      className={classes.root}
      defaultCollapseIcon={<MinusSquare />}
      defaultExpandIcon={<PlusSquare />}
      defaultEndIcon={<CloseSquare />}
      expanded={expanded}
      selected={selected}      
      onNodeToggle={handleToggle}
      onNodeSelect={handleSelect}      
      ref={ref}
    >
       {renderTree(data)}
    </TreeView>
  );

})

export default CustomizedTreeView
