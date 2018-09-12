software
=============

[![Build Status](https://travis-ci.org/edestecd/puppet-software.svg)](https://travis-ci.org/edestecd/puppet-software)
[![Puppet Forge](https://img.shields.io/puppetforge/v/edestecd/software.svg)](https://forge.puppet.com/edestecd/software)
[![Puppet Forge Downloads](https://img.shields.io/puppetforge/dt/edestecd/software.svg)](https://forge.puppet.com/edestecd/software)
[![Puppet Forge Score](https://img.shields.io/puppetforge/f/edestecd/software.svg)](https://forge.puppet.com/edestecd/software/scores)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with software](#setup)
    * [What software affects](#what-software-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with software](#beginning-with-software)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Contributors](#contributors)

## Overview

Puppet Module to install various Desktop Software

## Module Description

The software module provides classes to install many commonly needed Desktop Applications.  
Many of these applications require little or no configuration and are mostly Graphical.  
This module provides a quick way to get many repetitive apps installed.

This module currently supports:
* Apple Mac OS X
* Ubuntu Desktop
* Windows

Other modules exist for many of these applications and I have used some of them
as examples, but I prefer to manage these in one module.  
Each application has a class, which you may include separately to install
exactly the applications you desire.

## Setup

### What software affects

only installs apps (OS X) and packages (Ubuntu, Windows)

### Setup Requirements

only need to install the module

### Beginning with software

Install only Google Chrome browser:

```puppet
include software::browsers::chrome
```

## Usage

### Install various apps

```puppet
include software::browsers::chrome
include software::browsers::firefox
include software::database::pgcommander
include software::database::sequelpro
include software::editors::atom
include software::editors::textmate
include software::entertainment::vlc
include software::idesdk::android_studio
include software::idesdk::android_tools
include software::idesdk::pdk
include software::idesdk::tfenv
include software::prefpanes::launchrocket
include software::social::skype
include software::social::slack
include software::storage::fetch
include software::storage::filezilla
include software::utilities::controlplane
include software::utilities::iterm
include software::utilities::onyx
include software::vcsscm::git
include software::vcsscm::sourcetree
include software::virtualization::virtualbox
include software::virtualization::vagrant
include software::webstack::anvil
```

### Install everything in the browser group

```puppet
include software::browsers
```

### Install apps with hiera yaml

```puppet
hiera_include('classes')
```
```yaml
---
classes:
- software::browsers::chrome
- software::editors::atom
- software::entertainment::vlc
- software::social::skype
- software::vcsscm::git

software::browsers::chrome::channel: stable

software::editors::atom::packages:
  language-puppet: {}
  linter: {}
  linter-puppet-lint: {}
  linter-rubocop: {}
software::editors::atom::themes:
  twilight-syntax: {}
software::editors::atom::user: username

software::vcsscm::git:
  gui: true
  bash_completion: true
  bash_prompt: true
  gitconfig: true
  gitignore: puppet:///modules/custom/user/gitignore
```

## Reference

### Classes

* browsers
* database
* editors
* entertainment
* idesdk
* social
* storage
* utilities
* vcsscm
* virtualization
* webstack

## Limitations

Some proprietary software requires licenses.  
You may need to pass these license keys and possibly urls to use those classes.

This module has been built on and tested against Puppet 3.2.4 and higher.
While I am sure other versions work, I have not tested them.

This module supports modern OS X, Debian, Ubuntu, and Windows systems.

Many classes also support older versions of OS X, Ubuntu, and Windows.

## Development

Pull Requests welcome  
Please at least make sure ```rake test``` passes.

## Contributors

* Chris Edester ([edestecd](https://github.com/edestecd))
* comsolit AG ([comsolit](https://github.com/comsolit)) via Peter Bittner ([bittner](https://github.com/bittner))
