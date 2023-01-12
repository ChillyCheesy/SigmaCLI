<h1 align="center">Sigma - The Modulo CLI</h1>

<p align="center">
  <img src="logo.png" alt="sigma-logo" width="120px" height="120px"/>
  <br>
  <i>Sigma is a command line interface to install Modulo's server and create module faster
  <br>
</p>

# Installation

Make sure you have Ruby 3.0.0 installed.  
If you don't have Ruby installed, you can install it from [![Ruby](https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white)](https://www.ruby-lang.org/en/downloads/)

Install the dependencies using bundler`

```
gem install bundler  
bundle
```

# Usage

## Install a Modulo Server

You can install modulo's server by passing the flag '-m' or '--modulo' to the install command.  
This will ask you to select the version you want to download and install it.

```
sgm install -m
```

You can also specify the version you want to install by passing the version as an argument.

```
sgm install -m BINKS-0.3.0
```

## Install a Modulo Module

This feature is currently in work in progress.

## Generate a Modulo Module

You can generate a new Modulo module with the command new  
You also can give the command the name you want your module to be called (By default the generated module will be called 'NewModule')

```
sgm new TardisModule
```

## Check the version of Sigma

You can check the version of Sigma by simply using the command version

```
sgm version
```

## Check Modulo version

You can check the version of Modulo by using the command version and passing it the flag '-m'

```
sgm version -m
```

# Contributing

Bug reports and pull requests are welcome on GitHub !

[![Love Sigma](https://img.shields.io/badge/sigma-love-purple)](https://github.com/chillycheesy/sigmaCLI)   
**You love Modulo Sigma and bowties ? give us a :star:**