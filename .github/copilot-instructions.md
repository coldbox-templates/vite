# ColdBox Vite Template - AI Coding Instructions

This is a ColdBox application template integrated with **Vite 6** for modern frontend asset management, featuring **Vue 3** and **Tailwind CSS 4**. It combines traditional CFML development with modern JavaScript tooling for a full-stack development experience.

## 🏗️ Dual Development Environment

**Key Architecture**: This template runs **two separate dev servers** that work together:

1. **CommandBox Server** (`:8080`) - CFML application server
2. **Vite Dev Server** (`:5173`) - Hot Module Replacement (HMR) for frontend assets

The `vite-helpers` module bridges these environments, automatically detecting which mode you're in (dev vs production).

## 📁 Asset Structure

```
/resources/assets/          - Source files (NOT webroot)
├── css/
│   └── app.css            - Tailwind imports (@import "tailwindcss")
└── js/
    ├── app.js             - Vue app bootstrap
    └── components/
        └── Hello.vue      - Vue SFC components

/includes/                  - Public compiled assets (build output)
└── build/                 - Vite generates manifest.json here

/modules/vite-helpers/      - ColdBox module for asset loading
└── includes/helpers.cfm   - vite() helper function
```

**CRITICAL**: Edit files in `/resources/assets/`, NOT `/includes/build/`. Vite compiles from `resources/` to `includes/build/`.

## 🔄 Development Workflows

### Starting Development (Two Terminals Required)

```bash
# Terminal 1: Start ColdBox server
box server start

# Terminal 2: Start Vite HMR server
npm run dev
```

**How It Works**: 
- Vite creates `.vite/hot` file when dev server runs
- `vite()` helper detects this file and loads from `http://localhost:5173`
- Changes to `.vue`, `.js`, `.css` files trigger instant browser updates (HMR)
- No page refresh needed for frontend changes

### Production Build

```bash
# Build optimized assets (minified, versioned)
npm run build

# Generates /includes/build/manifest.json with hashed filenames
# vite() helper reads manifest for production asset paths
```

## 🎨 The vite() Helper Function

Located in `modules/vite-helpers/includes/helpers.cfm`:

```cfml
<!--- In layouts/Main.cfm --->
<head>
    #vite([
        "resources/assets/css/app.css",
        "resources/assets/js/app.js"
    ])#
</head>
```

**Development Mode** (when `.vite/hot` exists):
```html
<!-- Generates -->
<script type="module" src="http://localhost:5173/@vite/client"></script>
<script type="module" src="http://localhost:5173/resources/assets/js/app.js"></script>
<link rel="stylesheet" href="http://localhost:5173/resources/assets/css/app.css">
```

**Production Mode** (reads `includes/build/manifest.json`):
```html
<!-- Generates versioned, hashed filenames -->
<script type="module" src="/includes/build/app-a1b2c3d4.js"></script>
<link rel="stylesheet" href="/includes/build/app-e5f6g7h8.css">
```

**Behind the Scenes**: The `Vite.cfc` model handles:
- Hot file detection (`isRunningHot()`)
- Manifest parsing (`readManifest()`)
- Asset path generation with cache busting
- Automatic preload/modulepreload generation for code splitting

## ⚙️ Vite Configuration (vite.config.mjs)

```javascript
import { defineConfig } from "vite";
import vue from "@vitejs/plugin-vue";
import coldbox from "coldbox-vite-plugin";  // Critical for ColdBox integration
import tailwindcss from "@tailwindcss/vite";

export default defineConfig({
    plugins: [
        vue(),
        tailwindcss(),
        coldbox({
            input: [
                "resources/assets/css/app.css",
                "resources/assets/js/app.js"
            ],
            refresh: true  // Auto-refresh on CFML changes
        })
    ],
});
```

**coldbox-vite-plugin** features:
- Generates manifest.json in `includes/build/`
- Watches `.cfm`, `.cfc` files for changes (triggers browser refresh)
- Configures correct public directory and base URL
- Handles asset path resolution

## 🎭 Vue Integration Pattern

**Entry Point** (`resources/assets/js/app.js`):
```javascript
import { createApp } from "vue";
import Hello from "./components/Hello.vue";

createApp(Hello).mount("#app");
```

**Layout** (`layouts/Main.cfm`):
```cfml
<cfoutput>
<html>
<head>
    #vite(["resources/assets/css/app.css", "resources/assets/js/app.js"])#
</head>
<body>
    <div id="app">
        <!--- Vue takes over this div --->
        <Hello />
    </div>
</body>
</html>
</cfoutput>
```

**Component** (`resources/assets/js/components/Hello.vue`):
```vue
<template>
    <div class="h-screen flex items-center justify-center">
        <h1 class="text-6xl uppercase">
            Hello ColdBox Vite World!
        </h1>
    </div>
</template>
```

## 🎨 Tailwind CSS 4 Integration

**Simplified Import** (`resources/assets/css/app.css`):
```css
@import "tailwindcss";
```

Tailwind 4 uses Vite plugin (no separate config file needed). Classes work immediately in:
- `.vue` components (`<div class="flex items-center">`)
- `.cfm` views/layouts (`<div class="container mx-auto">`)

## 📦 Package Management

**box.json** (CFML dependencies):
```json
"dependencies": {
    "coldbox": "be",
    "vite-helpers": "^2.0.0"  // Provides vite() helper
}
```

**package.json** (Frontend dependencies):
```json
"dependencies": {
    "vue": "^3.5.22",
    "tailwindcss": "^4.1.14"
},
"devDependencies": {
    "vite": "^6.3.6",
    "@vitejs/plugin-vue": "6.0.1",
    "@tailwindcss/vite": "^4.1.14",
    "coldbox-vite-plugin": "^3.0.2"  // Critical for ColdBox integration
}
```

## 🚀 Build Commands

```bash
# CFML dependencies
box install

# Frontend dependencies
npm install

# Development (runs in background, Terminal 2)
npm run dev                # Start Vite HMR server

# Production build
npm run build              # Minify, version, generate manifest
                          # Output: includes/build/

# CFML formatting
box run-script format
box run-script format:watch

# Testing
box testbox run
```

## 🔍 Asset Loading Logic (Vite.cfc)

Key methods in `modules/vite-helpers/models/Vite.cfc`:

```cfml
function isRunningHot() {
    return fileExists(expandPath(variables.hotFilePath));  // .vite/hot
}

function render(required any entrypoints) {
    if (isRunningHot()) {
        // Dev mode: Load from Vite server
        return generateHotAssets(entrypoints);
    }
    
    // Production: Read manifest.json
    var manifest = readManifest();
    return generateProductionAssets(entrypoints, manifest);
}
```

**Manifest Structure** (`includes/build/manifest.json`):
```json
{
    "resources/assets/js/app.js": {
        "file": "assets/app-a1b2c3d4.js",
        "css": ["assets/app-e5f6g7h8.css"],
        "imports": ["_vendor-chunk.js"]
    }
}
```

## 🚨 Common Pitfalls

1. **Forgot `npm run dev`**: Assets return 404 or load uncompiled code - must run Vite server in dev
2. **Editing `/includes/build/`**: Changes get overwritten - edit `/resources/assets/` instead
3. **Missing `coldbox-vite-plugin`**: Manifest not generated or wrong paths - required in `vite.config.mjs`
4. **Wrong Asset Paths in vite()**: Must use exact source paths (`resources/assets/...`), not output paths
5. **Production 404s**: Forgot to run `npm run build` - production needs manifest.json
6. **HMR Not Working**: Check Vite server is running on `:5173` and `.vite/hot` file exists
7. **Tailwind Classes Not Working**: Must import in `app.css` - `@import "tailwindcss"`

## 📐 Adding New Assets

```cfml
<!--- 1. Create file in resources/assets/ --->
resources/assets/js/admin.js
resources/assets/css/admin.css

<!--- 2. Add to vite.config.mjs if new entry point --->
input: [
    "resources/assets/css/app.css",
    "resources/assets/js/app.js",
    "resources/assets/js/admin.js",  // New entry
    "resources/assets/css/admin.css"  // New entry
]

<!--- 3. Load in layout/view --->
#vite(["resources/assets/js/admin.js", "resources/assets/css/admin.css"])#
```

## 📚 Key Files

- `vite.config.mjs` - Vite configuration (plugins, entry points)
- `package.json` - Frontend dependencies and npm scripts
- `modules/vite-helpers/models/Vite.cfc` - Asset loading logic
- `modules/vite-helpers/includes/helpers.cfm` - vite() helper function
- `resources/assets/` - Source files (edit here)
- `includes/build/` - Compiled output (don't edit)

## 📖 Documentation

- Vite: https://vite.dev
- coldbox-vite-plugin: https://www.npmjs.com/package/coldbox-vite-plugin
- Vue 3: https://vuejs.org
- Tailwind CSS 4: https://tailwindcss.com
- ColdBox Vite Helpers: https://forgebox.io/view/vite-helpers
