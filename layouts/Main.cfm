<cfoutput>
<cfset manifest = loadViteManifest( force : false )/>
<!doctype html>
<html lang="en">
<head>
	<!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<title>Welcome to Coldbox!</title>

	<meta name="description" content="ColdBox Application Template">
    <meta name="author" content="Ortus Solutions, Corp">

	<!---Base URL --->
	<base href="#event.getHTMLBaseURL()#" />
	<cfif getSetting( "environment" ) NEQ "development">
		<link href="includes/js/#manifest[ "index.css" ][ "file" ]#" rel="stylesheet" />
	</cfif>
</head>
<body>
	<div id="app">
		<Hello />
	</div>
	<cfif getSetting( "environment" ) EQ "development">
		<script type="module" src="http://localhost:3000/@vite/client"></script>
		<script type="module" src="http://localhost:3000/app.js"></script>
	<cfelse>
		<script type="module" src="includes/js/#manifest[ "index.js" ][ "file" ]#"></script>
	</cfif>
</body>
</html>
</cfoutput>
