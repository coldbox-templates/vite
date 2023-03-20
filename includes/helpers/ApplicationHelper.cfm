<!--- All methods in this helper will be available in all handlers,views & layouts --->
<cfscript>
	/**
	 * Load the vite manifest, it caches it in the `default` cache for 1 day once loaded.
	 * You can remove it by reiniting your application or using the force argument.
	 *
	 * @manifest The location of the manifest, defaults to `includes/js/manifest.json`
	 * @force Force load the manifest even if cached.
	 */
	function loadViteManifest( manifest, boolean force = false ){
		param arguments.manifest = "#controller.getSetting( "ApplicationPath" )#includes/js/manifest.json";

		var cacheKey = "vite-manifest-#controller.getAppHash()#";
		var cache = getCache( "default" );

		if( arguments.force ){
			cache.clear( cacheKey );
		}

		return cache.getOrSet(
			cacheKey,
			function(){
				return fileExists( manifest ) ? deserializeJSON( fileRead( manifest ) ) : {};
			},
			1440, // 1 day
			0
		);
	}
</cfscript>
