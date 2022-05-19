[![nim-steam](https://socialify.git.ci/levshx/nim-steam/image?description=1&descriptionEditable=Steam%20Network%20Library&font=Inter&forks=1&logo=https%3A%2F%2Fraw.githubusercontent.com%2Flevshx%2Fnim-steam%2Fmain%2Fresources%2Fnim-steam.png%3Fraw%3Dtrue&owner=1&pattern=Floating%20Cogs&pulls=1&stargazers=1&theme=Dark)](https://github.com/levshx/nim-steam)


[![Build](https://github.com/levshx/nim-steam/actions/workflows/build_ci.yml/badge.svg)](https://github.com/levshx/nim-steam/actions/workflows/build_ci.yml)
[![Docs](https://github.com/levshx/nim-steam/actions/workflows/docs_ci.yml/badge.svg)](https://github.com/levshx/nim-steam/actions/workflows/docs_ci.yml)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](LICENSE)
[![NOT COMPLETE](https://img.shields.io/static/v1?label=WARNING&message=This%20library%20is%20still%20in%20heavy%20development&color=red)](https://github.com/levshx/nim-steam)

# <img src="http://forum.nim-lang.org/images/logo.png" style="height: 25px;"> nim-steam 

It can be installed through nimble with:

```
nimble install https://github.com/levshx/nim-steam
```

DocGen Tools:

```
git clone https://github.com/levshx/nim-steam.git
cd nim-steam
nimble docs
```
Docs on GitHub Pages:
https://levshx.github.io/nim-steam/

WebAPI Generator Tools (see more in docs):
```
git clone https://github.com/levshx/nim-steam.git
cd nim-steam
nimble webapi 
```

The project needs brains. In the near future, we need to make an implementation of steam/client. At the moment, an authorization request with RSA encryption is ready, but the cookie system is not ready.

# Modules

| Name          | Meaning         |
|:------------- |:---------------:|
| steam/webapi  | allows you to interact with the steam Web API |
| steam/client  | TODO  |
| steam/features| TODO |
| steam/guard   | TODO  |
| steam         | all of the above |



# Contributors

- [levshx](https://github.com/levshx)
