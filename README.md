[![Build Status](https://secure.travis-ci.org/spacepants/puppet-drupal.svg)](https://travis-ci.org/spacepants/puppet-drupal)

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with drupal](#setup)
    * [What drupal affects](#what-drupal-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with drupal](#beginning-with-drupal)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module for installing and managing many aspects of a Drupal multisite.

This originally was a fork of [Ben Ford's drupal module](https://github.com/binford2k/binford2k-drupal) but has since been rewritten in large parts.

## Module Description

This module installs and manages [Drush](https://github.com/drush-ops/drush) for Drupal management. It also incorporates [DSLM](https://www.drupal.org/project/dslm) for managing multiple versions of Drupal core and install profiles.

If applicable, this section should have a brief description of the technology the module integrates with and what that integration enables. This section should answer the questions: "What does this module *do*?" and "Why would I use it?"

If your module has a range of functionality (installation, configuration, management, etc.) this is the time to mention it.

## Setup

### What drupal affects

* A list of files, packages, services, or operations that the module will alter, impact, or execute on the system it's installed on.
* This is a great place to stick any warnings.
* Can be in list or paragraph form.

### Setup Requirements **OPTIONAL**

If your module requires anything extra before setting up (pluginsync enabled, etc.), mention it here.

### Beginning with drupal

The very basic steps needed for a user to get the module up and running.

If your most recent release breaks compatibility or requires particular steps for upgrading, you may wish to include an additional section here: Upgrading (For an example, see http://forge.puppetlabs.com/puppetlabs/firewall).

## Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here.

## Reference

Here, list the classes, types, providers, facts, etc contained in your module. This section should include all of the under-the-hood workings of your module so people know what the module is touching on their system but don't need to mess with things. (We are working on automating this section!)

## Limitations

This is where you list OS compatibility, version compatibility, etc.

## Development

Since your module is awesome, other users will want to play with it. Let them know what the ground rules for contributing are.

## Release Notes/Contributors/Etc **Optional**

If you aren't using changelog, put your release notes here (though you should consider using changelog). You may also add any additional sections you feel are necessary or important to include here. Please use the `## ` header.
