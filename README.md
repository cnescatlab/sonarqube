# CNES SonarQube image \[server\]

![](https://github.com/cnescatlab/sonarqube/workflows/CI/badge.svg)
![](https://github.com/cnescatlab/sonarqube/workflows/CD/badge.svg)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/2a4a53f54ae94bd69d66a7690b95612f)](https://www.codacy.com/gh/cnescatlab/sonarqube?utm_source=github.com&utm_medium=referral&utm_content=lequal/sonarqube&utm_campaign=Badge_Grade)

> Docker image for SonarQube with pre-configured plugins and settings by CNES dedicated to Continuous Integration.

This image is a pre-configured SonarQube server image derived from [Docker-CAT](https://github.com/cnescatlab/docker-cat). It contains the same plugins and the same rules for code analysis. It is based on the LTS version of SonarQube.

SonarQube itself is an open source project on GitHub: [SonarSource/sonarqube](https://github.com/SonarSource/sonarqube).

For versions and changelog: [GitHub Releases](https://github.com/cnescatlab/sonarqube/releases).

## Features

This image is based on the official SonarQube LTS image, namely [sonarqube:9.9.3-community](https://hub.docker.com/_/sonarqube), and offers additional features.

Additional features are:

- Mandatory modification of the default admin password to run a container.
- Healthcheck of the container.
- More plugins (see [the list](#sonarqube-plugins-included))
- CNES configuration
  - CNES Quality Profiles for Java, Python, C, C++ and VHDL
  - CNES Quality Gate (set as default)

_This image is made to be used in conjunction with a pre-configured sonar-scanner image that embeds all necessary tools: [cnescatlab/sonar-scanner](https://github.com/cnescatlab/sonar-scanner). It is, however, not mandatory to use it._

## Developer's guide

### How to build the image

It is a normal docker image. Thus, it can be built with the following commands.

```sh
# from the root of the project
$ docker build -t lequal/sonarqube .
```

To then run a container with this image see the [user guide](#user-guide).

To run the tests and create your own ones see the [test documentation](https://github.com/cnescatlab/sonarqube/tree/develop/tests).

## User guide

This image is available on Docker Hub: [lequal/sonarqube](https://hub.docker.com/r/lequal/sonarqube/).

Since inception, this image has been designed to be used in production. Thus, leaving the default admin password (namely "admin") will never be an option. To this extent, a new password for the admin account shall be given by setting the environment variable `SONARQUBE_ADMIN_PASSWORD`.

:warning: :rotating_light: The container will fail to run if `SONARQUBE_ADMIN_PASSWORD` is empty or equal to "admin".

To run the image locally:

```sh
# Recommended options
$ docker run --name lequalsonarqube \
             --rm \
             -p 9000:9000 \
             -e SONARQUBE_ADMIN_PASSWORD="admin password of your choice" \
             lequal/sonarqube:latest

# To stop (and remove) the container
Ctrl-C
# or
$ docker container stop lequalsonarqube
```

### Use an external database

By default, SonarQube uses an embedded database that can be used for tests but in production using an external database for data persistency is mandatory. The `docker-compose.yml` file shows an example of how to configure an external postgres database. It can be run with:

```sh
$ docker-compose up -d

# To set variables when running the containers
$ LEQUAL_SONARQUBE_VERSION=1.0.0 POSTGRES_PASSWD=secret-passwd SONARQUBE_ADMIN_PASSWORD="a password" docker-compose up -d
```

With an external database, the data used by SonarQube is stored outside of the container. It means that the container may be stopped, restarted, removed and recreated at will.

## SonarQube plugins included

| SonarQube plugin                                      | Version             | URL                                                                         |
| ----------------------------------------------------- | ------------------- | --------------------------------------------------------------------------- |
| Ansible Lint                                          | 2.5.1               | https://github.com/sbaudoin/sonar-ansible/sonar-ansible-plugin              |
| C# Code Quality and Security                          | 8.51 (build 59060)  | http://redirect.sonarsource.com/plugins/csharp.html                         |
| C++ (Community)                                       | 2.1 (build 428)     | https://github.com/SonarOpenCommunity/sonar-cxx/wiki                        |
| Checkstyle                                            | 10.9.3              | n/a                                                                         |
| Clover                                                | 4.1                 | https://github.com/sfeir-open-source/sonar-clover                           |
| Cobertura                                             | 2.0                 | https://github.com/galexandre/sonar-cobertura                               |
| Community Branch Plugin                               | 1.14.0              | https://github.com/mc1arke/sonarqube-community-branch-plugin                |
| Configuration detection fot Code Quality and Security | 1.2 (build 267)     | http://docs.sonarqube.org/display/PLUG/Plugin+Library/sonar-config/sonar-co |
| Findbugs                                              | 4.2.3               | https://github.com/spotbugs/sonar-findbugs/                                 |
| Flex Code Quality and Security                        | 2.8 (build 3166)    | http://redirect.sonarsource.com/plugins/flex.html                           |
| Go Code Quality and Security                          | 1.11.0 (build 3905) | http://redirect.sonarsource.com/plugins/go.html                             |
| HTML Code Quality and Security                        | 3.7.1 (build 3306)  | http://redirect.sonarsource.com/plugins/web.html                            |
| IaC Code Quality and Security                         | 1.11 (build 2847)   | http://docs.sonarqube.org/display/PLUG/Plugin+Library/iac/sonar-iac-plugin  |
| JaCoCo                                                | 1.3.0 (build 1538)  | n/a                                                                         |
| Java Code Quality and Security                        | 7.16 (build 30901)  | http://redirect.sonarsource.com/plugins/java.html                           |
| JavaScript/TypeScript/CSS Code Quality and Security   | 9.13 (build 20537)  | http://redirect.sonarsource.com/plugins/javascript.html                     |
| Kotlin Code Quality and Security                      | 2.12.0 (build 1956) | https://redirect.sonarsource.com/plugins/kotlin.html                        |
| PHP Code Quality and Security                         | 3.27.1 (build 9352) | http://redirect.sonarsource.com/plugins/php.html                            |
| PMD                                                   | 3.4.0               | https://github.com/jborgers/sonar-pmd                                       |
| Python Code Quality and Security                      | 3.24 (build 10784)  | http://redirect.sonarsource.com/plugins/python.html                         |
| Ruby Code Quality and Security                        | 1.11.0 (build 3905) | http://redirect.sonarsource.com/plugins/ruby.html                           |
| Scala Code Quality and Security                       | 1.11.0 (build 3905) | http://redirect.sonarsource.com/plugins/scala.html                          |
| ShellCheck Analyzer                                   | 2.5.0               | https://github.com/sbaudoin/sonar-shellcheck                                |
| Sonar i-Code CNES plugin                              | 3.1.1               | https://github.com/cnescatlab/sonar-icode-cnes-plugin                       |
| SonarQube CNES Report                                 | 4.2.0               | https://github.com/cnescatlab/sonar-cnes-report                             |
| SonarTS                                               | 2.1 (build 4362)    | http://redirect.sonarsource.com/plugins/typescript.html                     |
| Text Code Quality and Security                        | 2.0.2 (build 1090)  | http://docs.sonarqube.org/display/PLUG/Plugin+Library/text/sonar-text-plugi |
| VB.NET Code Quality and Security                      | 8.51 (build 59060)  | http://redirect.sonarsource.com/plugins/vbnet.html                          |
| VHDLRC                                                | 3.4                 | https://www.linty-services.com                                              |
| XML Code Quality and Security                         | 2.7 (build 3820)    | http://redirect.sonarsource.com/plugins/xml.html                            |
| YAML Analyzer                                         | 1.7.0               | https://github.com/sbaudoin/sonar-yaml                                      |

To update this list run the following script:

```sh "
while IFS='|' read -r plugin version url
do
    if [ "$url" = "null" ]; then url="n/a"; fi
    printf "| %.60s| %.25s| %.75s|\n" "$plugin                                                            " "$version                         " "$url                                                                           "
done < <(curl -u MY_TOKEN: -s http://localhost:9000/api/plugins/installed | jq -r '.plugins[] | "\(.name)|\(.version)|\(.homepageUrl)"')

# With `MY_TOKEN` your SonarQube personal token.
```

### Additional information for the Community Branch Plugin

It is advised to set the property `sonar.core.serverBaseURL` in [/admin/settings](http://localhost:9000/admin/settings) for the links posted in PR comments and mail to work.

## How to contribute

If you experienced a problem with the image please open an issue. Inside this issue please explain us how to reproduce this issue and paste the log.

If you want to do a PR, please put inside of it the reason of this pull request. If this pull request fixes an issue please insert the number of the issue or explain inside of the PR how to reproduce this issue.

All details are available in [CONTRIBUTING](https://github.com/cnescatlab/.github/blob/master/CONTRIBUTING.md).

Bugs and feature requests: [issues](https://github.com/cnescatlab/sonarqube/issues)

To contribute to the project, read [this](https://github.com/cnescatlab/.github/wiki/CATLab's-Workflows) about CATLab's workflows for Docker images.

## License

Licensed under the [GNU General Public License, Version 3.0](https://www.gnu.org/licenses/gpl.txt)

This project is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
