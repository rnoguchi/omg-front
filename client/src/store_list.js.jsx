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
    width:500,
    overflowY:'auto',
  },
};

let dialogProps = {};

//let storeInfos = new Array();

//let storeDetailInfos = new Array();

let storeGroupId = {};

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
  		this.setState({storeDetailInfos : JSON.parse(res.text)});
  		this.setState({open:true});
  	}.bind(this));
  };

  handleOpen = (e) => {
  	storeGroupId = e.currentTarget.getAttribute('id')
    this.getStoreDetail();
  };

  handleClose = () => {
  	this.setState({open:false});
  };

  createDialogProps()  {
  	dialogProps = {
  		id: storeDetailInfo.id,
  		store_name: storeDetailInfo.store_name,
  		average_dinner_price: storeDetailInfo.average_dinner_price,
  		average_lunch_price: storeDetailInfo.average_lunch_price,
  		business_hours: storeDetailInfo.business_hours,
  		created_at: storeDetailInfo.created_at,
  		evaluation_score: storeDetailInfo.evaluation_score,
  		genre: storeDetailInfo.genre,
  		gs_cd: storeDetailInfo.gs_cd,
  		holiday: storeDetailInfo.holiday,
  		id: storeDetailInfo.id,
  		mobile_site_url: storeDetailInfo.mobile_site_url,
  		pc_site_url: storeDetailInfo.pc_site_url,
  		reg_apl: storeDetailInfo.reg_apl,
  		reg_date: storeDetailInfo.reg_date,
  		store_id: storeDetailInfo.store_id,
  		store_img_url: storeDetailInfo.store_img_url,
  		store_name: storeDetailInfo.store_name,
  		visit_already_flg: storeDetailInfo.visit_already_flg,
  		store_group_id: storeDetailInfo.store_group_id,
  		handleCloseCallBack: this.handleClose
  	}
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
          actionIcon={<IconButton onClick={this.handleOpen} id={storeInfo.store_group_id}><StarBorder color="white" /></IconButton>}>
          <img src={storeInfo.store_img_url} />
        </GridTile>

      ))}

      <StoreDetail storeDetailInfos={this.state.storeDetailInfos} open={this.state.open} handleCloseCallBack={this.handleClose}/>
    </GridList>
  </div>
  )};
};

export default GrmGridList;
