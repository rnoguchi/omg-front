import ReactDOM from 'react-dom'
import Header from './header.js.jsx'
import GrmGridList from './store_list.js.jsx'
import baseTheme from 'material-ui/styles/baseThemes/lightBaseTheme';
import getMuiTheme from 'material-ui/styles/getMuiTheme';
import { Router, Route, IndexRoute, Link, IndexLink, browserHistory } from 'react-router';

class GrmList extends React.Component {
	constructor(props) {
      super(props);
    }

    getChildContext() {
      return { muiTheme: getMuiTheme(baseTheme) };
    }

	render() {
		return (
		<div>
			<Header/>
			<GrmGridList/>

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
