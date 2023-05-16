module.exports = {
	purge : [
		"./resources/assets/js/**/*.{vue,js,ts,jsx,tsx}",
		"./layouts/**/*.{html,cfm}",
		"./views/**/*.{html,cfm}"
	],
	darkMode : false, // or 'media' or 'class'
	theme    : { extend: {}, },
	variants : { extend: {}, },
	plugins  : [],
};
