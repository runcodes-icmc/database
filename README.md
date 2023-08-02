# run.codes Database

This project houses the database schemas for the PostgreSQL database that
feeds the whole run.codes application.

## Structure

This project is very simple in its structure. The most important directory is the `schema/`.
It houses the SQL files used to build the whole database, there are, currently, three variants:

- `schema/base.sql`
  - The *base* file, as the name suggests, is the most "raw" form of the SQL file, constructing
    only the tables and overall structure, without including any pre-defined data.
- `schema/development.sql`
  - The *development* file extends the *base* one, adding some initial data for simplifying the
    development process, like pre-registred users and universities.
- `schema/production.sql`
  - The *production* file also extends the *base* one, but doesn't include much initial data, the
    only information included is a initial **admin** user, which can then be used to setup and 
    control the application.

## Docker

To simplify the deployment and testing of the application, there are some base Docker files that
extends the default `postgres` one, the only change it makes is the inclusion of the initialization
SQL code for each of the environments.

There are, currently, two variants:

- `docker/Dockerfile.development`
  - Which initializes the database with the `schema/development.sql` file.
- `docker/Dockerfile.production`
  - Which initializes the database with the `schema/production.sql` file.

The recommended way to build and tag these images are as follows (all commands assume that
you are on the root of this repository):

### Building the development image

```sh
docker build -t runcodes-database:development -f ./docker/Dockerfile.development .
```

### Building the production image

```sh
docker build -t runcodes-database:production -f ./docker/Dockerfile.production .
```

## Makefile

To simplify the building process by not needing to run those commands "by hand" all
the time, there is also a Makefile that automates it. So you can just run:

- `make production`
  - To build and tag the production image.
- `make development`
  - To build and tag the development image.
- `make` or `make all`
  - To build and tag both images.

## License

For information on the license of this project, please see our [license file](LICENSE.md).

## Contributors

For information of the contributors of this project, please see our [contributors file](CONTRIBUTORS.md).

## Contributing

For information on contributing to this project, please see our [contribution guidelines](CONTRIBUTING.md).
