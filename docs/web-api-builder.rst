====================
WebAPI builder guide
====================

:Author: levshx
:Version: 0.0.2

Introduction
============

This document describes the usage of the *WebAPI builder*
This is the second, more detailed version of the Steam Web API implementation.

WebAPI builder is free software; it is licensed under the
`MIT License <http://www.opensource.org/licenses/mit-license.php>`_.

To begin with, I will say that the compiled library is created
based on JSON API data at the link: 
`WebAPI JSON <https://api.steampowered.com/ISteamWebAPIUtil/GetSupportedAPIList/v1/>`_.
The compiler parses this data and creates a WebAPI library. 
The Steam Web API documentation may have errors, as it is 
developed and modified at their discretion. The compiled library 
can be changed manually. This is necessary because Steam 
provides different Web APIs for different users.

Compiler Usage
==============

At the root of the project is 
`webapibuilder.nim <https://github.com/levshx/nim-steam/blob/devel/webapibuilder.nim>`_, this is a 
program that takes the parameter of the Web API key and 
generates the library code.

To compile the library, run the command in the root of the 
repository: `nim c -r webapibuilder KEY`, where the `KEY` is your 
Web API key provided on https://steamcommunity.com/dev/apikey
If you don't want to use the key, you can use the `-keyless` 
parameter, but this build will be limited and won't have many 
features.

The assembly will be placed at the path :
`/buildedwebapi/builded_webapi.nim` 

How to use
==========

The library provides 2 types of client, synchronous and asynchronous.
To create a client, run:

*var client = newSteamWebAPI()
var asyncClient = newAsyncSteamWebAPI()*

This object stores the objects of the Steam WebAPI interfaces as 
variables that you can access. 
The interfaces themselves have information about the methods of 
themselves, this is `name: string` and `methods: seq[string]`
method format in `methods[<index>]`: `METHOD_NAME:VERSION`.
Interface names begin with the letter `I`.

Methods of this interface correspond to each interface, the names 
of these methods are generated in the following format:
`MethodNameV1(*args):string`, where `V1` corresponds to version `1`. 
For example:
*let result = client.ISteamWebAPIUtil.GetSupportedAPIListV1()*