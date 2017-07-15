import React from 'react';
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';
import {GridList, GridTile} from 'material-ui/GridList';
import Subheader from 'material-ui/Subheader';
import request from 'superagent';

  const customContentStyle = {
  	width: '100%',
  	maxWidth: 'none',
  };

const styles = {
  root: {
    display: 'flex',
    flexWrap: 'wrap',
    justifyContent: 'space-around',
  },
  gridList: {
    width: '50%',
    height: '100%',
    overflowY: 'auto',
  },
  titleStyle: {
    color: 'rgb(0, 188, 212)',
    textDecoration: 'none',
  },
};

class StoreDetail extends React.Component {

  constructor(props) {
    super(props);
  };

  render() {

 // ダイアログ内のアクション
  const dialogAction = [
    <FlatButton
      label="Close"
      primary={true}
      onClick={this.props.handleCloseCallBack}
    />
  ];
  var storeName = "";
  	return (

  	    <Dialog
          title={this.props.storeName}
          actions={dialogAction}
          modal={false}
          open={this.props.open}
          autoScrollBodyContent={true}
          contentStyle={customContentStyle}
        >
        <GridList
          style={styles.gridList}>

          {this.props.storeDetailInfos.map((storeDetail) => (
            <GridTile
              cols={2}
              title={<a href={storeDetail.pc_site_url} target="_blank">{storeDetail.gs_name}サイトへ移動</a>}
              titleStyle={styles.titleStyle}
            >
            <img src={storeDetail.store_img_url} width='90' height='90'/>
            </GridTile>
          ))}

        </GridList>
        </Dialog>
  	)
  };
};

export default StoreDetail;