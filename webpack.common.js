// webpack.common.js - common webpack config
const LEGACY_CONFIG = 'legacy';
const MODERN_CONFIG = 'modern';

// node modules
const path = require('path');
const merge = require('webpack-merge');

// webpack
const webpack = require('webpack');

// webpack plugins
const CopyWebpackPlugin = require('copy-webpack-plugin');
/* -- Does not yet work with Vue 3
const ForkTsCheckerWebpackPlugin = require('fork-ts-checker-webpack-plugin');
const ForkTsCheckerNotifierWebpackPlugin = require('fork-ts-checker-notifier-webpack-plugin');
*/
const ManifestPlugin = require('webpack-manifest-plugin');
const { VueLoaderPlugin } = require('vue-loader');
const WebpackNotifierPlugin = require('webpack-notifier');

// config files
const pkg = require('./package.json');
const settings = require('./webpack.settings.js');

// Configure Babel loader
const configureBabelLoader = (browserList, legacy) => {
    return {
        test: /\.js$/,
        exclude: settings.babelLoaderConfig.exclude,
        use: {
            loader: 'babel-loader',
            options: {
                cacheDirectory: true,
                sourceType: 'unambiguous',
                presets: [
                    [
                        '@babel/preset-env', {
                        modules: legacy ? "auto" : false,
                        corejs: {
                            version: 3,
                            proposals: true
                        },
                        debug: false,
                        useBuiltIns: 'usage',
                        targets: {
                            browsers: browserList,
                        },
                    }
                    ],
                    [
                        '@babel/preset-typescript', {
                        'allExtensions': true,
                        'isTSX': false,
                    }
                    ],
                ],
                plugins: [
                    '@babel/plugin-syntax-dynamic-import',
                    '@babel/plugin-transform-runtime',
                    '@babel/plugin-proposal-class-properties',
                    '@babel/plugin-proposal-object-rest-spread',
                    '@babel/plugin-proposal-nullish-coalescing-operator',
                    '@babel/plugin-proposal-optional-chaining',
                ],
            },
        },
    };
};

// Configure TypeScript loader
const configureTypeScriptLoader = () => {
    return {
        test: /\.ts$/,
        exclude: settings.typescriptLoaderConfig.exclude,
        use: {
            loader: 'ts-loader',
            options: {
                transpileOnly: true,
                appendTsSuffixTo: [/\.vue$/],
                happyPackMode: false,
            },
        },
    };
};

// Configure Entries
const configureEntries = () => {
    let entries = {};
    for (const [key, value] of Object.entries(settings.entries)) {
        entries[key] = path.resolve(__dirname, settings.paths.src.js + value);
    }

    return entries;
};

// Configure Font loader
const configureFontLoader = () => {
    return {
        test: /\.(ttf|eot|woff2?)$/i,
        use: [
            {
                loader: 'file-loader',
                options: {
                    name: 'fonts/[name].[ext]'
                }
            }
        ]
    };
};

// Configure Manifest
const configureManifest = (fileName) => {
    return {
        fileName: fileName,
        basePath: settings.manifestConfig.basePath,
        map: (file) => {
            file.name = file.name.replace(/(\.[a-f0-9]{32})(\..*)$/, '$2');
            return file;
        },
    };
};

// Configure Vue loader
const configureVueLoader = () => {
    return {
        test: /\.vue$/,
        loader: 'vue-loader'
    };
};

// The base webpack config
const baseConfig = {
    name: pkg.name,
    entry: configureEntries(),
    output: {
        path: path.resolve(__dirname, settings.paths.dist.base),
        publicPath: settings.urls.publicPath()
    },
    resolve: {
        extensions: ['.ts', '.js', '.vue', '.json'],
        alias: {
            'vue$': 'vue/dist/vue.esm-bundler.js'
        },
        modules: [
            path.resolve(__dirname, 'node_modules'),
        ],
    },
    module: {
        rules: [
            configureFontLoader(),
            configureVueLoader(),
        ],
    },
    plugins: [
    new WebpackNotifierPlugin({title: 'Webpack', excludeWarnings: true, alwaysNotify: true}),
    new VueLoaderPlugin(),
    /* -- https://github.com/vuejs/vue-next/tree/master/packages/vue#bundler-build-feature-flags */
    new webpack.DefinePlugin({
        __VUE_OPTIONS_API__: true,
        __VUE_PROD_DEVTOOLS__: false
    }),
    /* -- Does not yet work with Vue 3
            new ForkTsCheckerWebpackPlugin({
                typescript: {
                    configFile: '../../tsconfig.json',
                    extensions: {
                        vue: true
                    }
                }
            }),
            new ForkTsCheckerNotifierWebpackPlugin({
                title: 'Webpack',
                excludeWarnings: true,
                alwaysNotify: false,
            }),
     */
]
};

// Legacy webpack config
const legacyConfig = {
    module: {
        rules: [
            configureBabelLoader(Object.values(pkg.browserslist.legacyBrowsers, true)),
            configureTypeScriptLoader(),
        ],
    },
    plugins: [
        new CopyWebpackPlugin(
            settings.copyWebpackConfig
        ),
        new ManifestPlugin(
            configureManifest('manifest-legacy.json')
        ),
    ]
};

// Modern webpack config
const modernConfig = {
    module: {
        rules: [
            configureBabelLoader(Object.values(pkg.browserslist.modernBrowsers, false)),
            configureTypeScriptLoader(),
        ],
    },
    plugins: [
        new ManifestPlugin(
            configureManifest('manifest.json')
        ),
    ]
};

// Common module exports
// noinspection WebpackConfigHighlighting
module.exports = {
    'legacyConfig': merge.strategy({
        module: 'prepend',
        plugins: 'prepend',
    })(
        baseConfig,
        legacyConfig,
    ),
    'modernConfig': merge.strategy({
        module: 'prepend',
        plugins: 'prepend',
    })(
        baseConfig,
        modernConfig,
    ),
};
