#!/usr/bin/env node

const fse = require('fs-extra');
const path = require('path');
const sass = require('sass');

const pkgName = require('../package').name;
console.log(`Building ${pkgName}...`);

const nodeModulesPath = path.resolve(__dirname, '../node_modules');
const themePath = path.resolve(__dirname, '../theme');
const scssPath = path.resolve(__dirname, '../scss');

// Copy assets from package dependencies to theme dir
const requiredDirectories = ['login/resources/css', 'login/resources/js'];
for (const dir of requiredDirectories) {
  const requiredPath = path.join(themePath, dir);
  fse.ensureDirSync(requiredPath);
}

const assetDependencies = [
  { src: 'jquery/dist/jquery.min.js', dst: 'login/resources/js/jquery.min.js' },
  { src: 'bootstrap/dist/js/bootstrap.min.js', dst: 'login/resources/js/bootstrap.min.js' }
];
for (const dependency of assetDependencies) {
  const srcPath = path.join(nodeModulesPath, dependency.src);
  const dstPath = path.join(themePath, dependency.dst);
  fse.copySync(srcPath, dstPath);
}

// Generate CSS from SCSS and write to theme dir
const scssStylePath = path.join(scssPath, 'style.scss');
const result = sass.renderSync({
  file: scssStylePath,
  includePaths: [nodeModulesPath]
});

const loginCssPath = path.join(themePath, 'login/resources/css/login.css');
fse.writeFileSync(loginCssPath, result.css);

console.log('Done.');
