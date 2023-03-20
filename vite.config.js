const { createVuePlugin } = require( "vite-plugin-vue2" );

/**
 * @type {import('vite').UserConfig}
 */
export default {
	alias        : { vue: "vue/dist/vue.esm.js", },
	optimizeDeps : { include: [ "vue/dist/vue.esm.js" ] },
	root         : process.cwd() + "/resources/assets/js",
	plugins      : [ createVuePlugin() ],
	build        : {
		manifest : true,
		outDir   : "../../../includes/vite",
	},
};
