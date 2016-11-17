import ReactDOM from 'react-dom'
import Header from './header.js.jsx'
import baseTheme from 'material-ui/styles/baseThemes/lightBaseTheme'
import getMuiTheme from 'material-ui/styles/getMuiTheme'

class GrmList extends React.Component{
  constructor(props) {
  	super(props);
  	this.state = {datas: []};
  }
  getChildContext() {
    return { muiTheme: getMuiTheme(baseTheme) };
  }
  componentWillMount() {
    $.ajax({
       url: '/api/v1/grmlist/',
       dataType: 'json',
       success: function(result) {
         this.setState({datas: result});
       }.bind(this),
       error: function(xhr, status, err) {
         console.error(this.props.url, status, err.toString());
       }.bind(this)
    });
  }
  render() {
    var dataList = this.state.datas.map(function(data) {
      return (
        <li key={data.store_id}> {data.store_id}</li>
      );
  	});
    return (
      <div>
        <Header/>
        <div className="GrmList">
          {dataList}
        </div>
      </div>
    );
  }
}
GrmList.childContextTypes = {
  muiTheme: React.PropTypes.object.isRequired,
};
ReactDOM.render(
  <GrmList />,
  document.getElementById('content')
);
