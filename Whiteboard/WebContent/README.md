ViewSync Plus
=============

ViewSync Plus is a multi-video player with fine-grained playback controls. It uses the native HTML5 video player and works on all modern browsers.

## Requirements
* Node.js v6.x
* npm

## Building
The static build system uses gulp to perform basic minification and versioning of files.

Build to `./public`:
`gulp`

Continuously build when changes are detected:
`gulp watch`

## Deployment
ViewSync Plus is a pure frontend application and only uses static resource files. Any web server capable of serving static resource files should work (Apache, nginx, lighttpd, etc.) Simply point the root directory to a built `public` folder.

## Contact
Andrew Chang: andrew@redbanhammer.com