# oxidized

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with oxidized](#setup)
    * [What oxidized affects](#what-oxidized-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with oxidized](#beginning-with-oxidized)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)
5. [Development - Guide for contributing to the module](#development)

## Description

This module will manage [oxidized](https://github.com/ytti/oxidized)

## Setup

### What oxidized affects

This module will install the oxidize gems and manage the oxidize configs. The gems are installed into SCL Ruby for RedHat based systems.

### Setup Requirements

This module has a soft dependency on [waveclaw/subscription_manager](https://forge.puppet.com/waveclaw/subscription_manager) for Red Hat systems in order to enable the SCL repository.

## Usage

To install oxidized and get a default config:

```puppet
include ::oxidized
```

To define a config:

```puppet
class { '::oxidized':
  config => {
    'rest' => false,
  }
}
```

## Reference

[http://treydock.github.io/puppet-module-oxidized/](http://treydock.github.io/puppet-module-oxidized/)
