var GrmList = React.createClass({
  getInitialState: function() {
  	return {datas: []};
  },
  componentWillMount: function() {
    $.ajax({
       url: this.props.url,
       dataType: 'json',
       success: function(result) {
         this.setState({datas: result});
       }.bind(this),
       error: function(xhr, status, err) {
         console.error(this.props.url, status, err.toString());
       }.bind(this)
    });
  },
  render: function() {
    var dataList = this.state.datas.map(function(data) {
      return (
        <li key={data.store_id}> {data.store_id}</li>
      );
  	});
    return (
      <div className="GrmList">
        {dataList}
      </div>
    );
  }
});
