import React from 'react';
import AppBar from 'material-ui/AppBar';
import baseTheme from 'material-ui/styles/baseThemes/lightBaseTheme';
import getMuiTheme from 'material-ui/styles/getMuiTheme';

const Header = () => (
   <AppBar
     title="Oh! My Gourmet"
     iconClassNameRight="muidocs-icon-navigation-expand-more"
   />
 );

export default Header