<cfoutput>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<title>Welcome to Coldbox!</title>

	<meta name="description" content="ColdBox Application Template">
    <meta name="author" content="Ortus Solutions, Corp">

	<!---Base URL --->
	<base href="#event.getHTMLBaseURL()#" />
	#vite( [ "resources/assets/css/app.css", "resources/assets/js/app.js" ] )#
</head>
<body>
	<div id="app">
		<Hello />
	</div>
</body>
</html>
</cfoutput>
