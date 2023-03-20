import "vite/dynamic-import-polyfill";
import Vue from "vue";
import Hello from "./components/Hello.vue";
import "../css/tailwind.css";

let app = document.getElementById( "app" );

new Vue( { components: { Hello } } ).$mount( app );
