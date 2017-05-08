import React from 'react';
import Dialog from 'material-ui/Dialog';
import FlatButton from 'material-ui/FlatButton';
import request from 'superagent';

  const customContentStyle = {
  	width: '100%',
  	maxWidth: 'none',
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

  	return (

  	    <Dialog
          title={"STORE INFO"}
          actions={dialogAction}
          modal={false}
          open={this.props.open}
          autoScrollBodyContent={true}
          contentStyle={customContentStyle}
        >
        {(() => {
          if (this.props.open) {
            return (
              this.props.storeDetailInfos.map((storeDetail) => (
              	<div> {storeDetail.store_name} </div>
              ))
            )
          }
        })()}
        </Dialog>
  	)
  };
};

export default StoreDetail;