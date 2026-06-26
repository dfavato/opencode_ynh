# OpenCode for YunoHost

[![Integration level](https://dash.yunohost.org/integration/opencode.svg)](https://dash.yunohost.org/appci/app/opencode) ![Working status](https://ci-apps.yunohost.org/ci/badges/opencode.status.svg) ![Maintenance status](https://ci-apps.yunohost.org/ci/badges/opencode.maintain.svg)

> *This package allows you to install OpenCode quickly and simply on a YunoHost server.
If you don't have YunoHost, please consult [the guide](https://doc.yunohost.org/admin/get_started/install_on/) to learn how to install it.*

## Overview

OpenCode is an open source AI coding agent that provides a powerful AI-assisted coding experience through your browser. It runs as a web application, making it accessible from any device on your network.

**Shipped version:** 1.17.9~ynh1

## Screenshots

![Screenshot of OpenCode web interface](./doc/screenshots/example.jpg)

## Disclaimers / important information

* The web interface is protected by YunoHost's SSO/ldap authentication
* No database is required to run this application
* For now only opencode zen api-key can be configured in the configuration panel
* The opencode.jsonc config file can be added in the configuration panel, bot other files (skills, agents, etc.) cannot.
* You can edit you Opencode skills and agents using opencode web interface.

## Documentation and resources

* Official website: <https://opencode.ai>
* Official documentation: <https://opencode.ai/docs>
* Upstream code repository: <https://github.com/anomalyco/opencode>
* YunoHost documentation for this app: <https://github.com/dfavato/opencode_ynh>
* Report a bug: <https://github.com/dfavato/opencode_ynh/issues>

## Developer info

Please send your pull request to the [testing branch](https://github.com/dfavato/opencode_ynh/tree/testing).

To try the testing branch, please proceed like that.

``` bash
sudo yunohost app install https://github.com/dfavato/opencode_ynh/tree/testing --debug
or
sudo yunohost app upgrade opencode -u https://github.com/dfavato/opencode_ynh/tree/testing --debug
```

**More info regarding app packaging:** <https://doc.yunohost.org/dev/packaging/>
