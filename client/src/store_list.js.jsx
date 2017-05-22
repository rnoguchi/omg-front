import React from 'react';
import {GridList, GridTile} from 'material-ui/GridList';
import IconButton from 'material-ui/IconButton';
import Subheader from 'material-ui/Subheader';
import StarBorder from 'material-ui/svg-icons/toggle/star-border';
import RaisedButton from 'material-ui/RaisedButton';
import request from 'superagent';
import StoreDetail from './store_detail.js.jsx';

const styles = {
  root:{
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'space-around',
  },
  gridList:{
    width:'80%',
    overflowY:'auto',
  },
};

let storeGroupId = "";
let storeName = "";

class GrmGridList extends React.Component{

  constructor(props) {
    super(props);
    this.state = {
      open : false,
      storeInfos : new Array(),
      storeDetailInfos : new Array(),

    };
  };

  componentWillMount() {
    this.getStoreInfos();
  };

  getStoreInfos() {
    request.get('/api/v1/grmlist/')
    .end(function(err, res){
    	if(err) {alert(res.text);}
    	this.setState({storeInfos : JSON.parse(res.text)});
    }.bind(this));
  };

  getStoreDetail() {
  	let detailApiUrl = '/api/v1/grmlist/' + storeGroupId;
  	request.get(detailApiUrl)
  	.end(function(err, res) {
  		if(err) {alert(res.text);}
  		let result = JSON.parse(res.text);
  		if (result && result.length > 0) {
  			this.setState({storeDetailInfos : result});
  		    this.setState({open:true});
  		}
  	}.bind(this));
  };

  handleOpen = (e) => {
  	storeGroupId = e.currentTarget.getAttribute('id')
  	storeName = e.currentTarget.getAttribute('name')
    this.getStoreDetail();
  };

  handleClose = () => {
  	this.setState({open:false});
  };

  render() {

  return (

  <div style={styles.root}>

    <GridList
      cellHeight={180}
      style={styles.gridList}
    >
      <Subheader>STORE LIST</Subheader>

      {this.state.storeInfos.map((storeInfo) => (

        <GridTile
          key={storeInfo.id}
          title={storeInfo.store_name}
          actionIcon={<IconButton onClick={this.handleOpen} name={storeInfo.store_name} id={storeInfo.store_group_id}><StarBorder color="white" /></IconButton>}>
          <img src={storeInfo.store_img_url} />
        </GridTile>

      ))}

      <StoreDetail
        storeDetailInfos={this.state.storeDetailInfos}
        open={this.state.open}
        handleCloseCallBack={this.handleClose}
        storeName={storeName}
      />
    </GridList>
  </div>
  )};
};

export default GrmGridList;
