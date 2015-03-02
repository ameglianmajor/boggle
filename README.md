# Boggle

This Boggle web application can be used to solve an arbitrary sized boggle
board. This web application finds all words on the specified Boggle board
that are in the dictionary that is loaded. This repository includes several
word lists, which can be used.

## Quick Start

1. Install [rvm](https://rvm.io/rvm/install) or
   [rbenv](https://github.com/sstephenson/rbenv#installation) if one of them is
   not already installed.
2. Install ruby-2.1.5 if it is not already installed.
3. Install bundler with the following command if it is not already installed.

   ```bash
   gem install bundler
   ```
4. After checking out the boggle github repository into a local directory,
   use bundler to install the required dependencies. Some of the dependencies
   may require the installation of system packages.

   ```bash
   bundle
   ```
5. Setup a postgres database with a boggle user that can create databases
   and login with the credential 'password'. See config/database.yml for
   configuration details. This can be done in many ways, but the following
   commands may be useful. However, they may not work depending on your
   operating system.
  1. At the bash prompt, start psql to setup a user for the first time.

     ```bash
     sudo -u postgres psql template1
     ```
  2. At the psql prompt, create a boggle user that can create databases
     and login using the password 'password'.

     ```psql
     create role boggle with createdb login password 'password';
     ```
6. Run the following commands at the bash prompt to create development and test
   databases, run the migrations, and start the rails server.

   ```bash
   rake db:create
   rake db:migrate
   rails s
   ```

## Quick Test

Once the Boggle Web Application is running locally on port 3000, visit the
following url.

http://localhost:3000

Rules can be found in the About tab or letters can be entered in the Boggle
board that is displayed. Keep the following rules in mind.

The following rules must be followed when entering letters.
1. If 'q' is entered, it must be followed by 'u' in the same square.
2. Unless the unit is 'qu', only one letter can be entered in a given square.
3. The case is ignored. Either upper-case or lower-case letters can be entered.
4. Only a single letter can be entered in each square unless it is a 'qu', 'Qu',
   'qU', or 'QU'.

## Apipie Documentation

To view the Apipie documentation, visit the following url after running the
Boggle Web Application locally on port 3000.

http://localhost:3000/apipie

## Tests

This section is broken down into a section for running tests and a section for
viewing the test coverage report.

### Running Tests

To run the Rspec tests, run the following command in the root directory of
the Boggle web application. Capybara was used to construct feature tests, and
these tests will also run when rspec is run.

```bash
rspec
```

### Viewing Test Coverage Report

To view the test coverage report, which is generated when running rspec, run
the following command after running the rspec tests. These commands should be
run from the root directory of the Boggle web application.

Ubuntu

```bash
firefox coverage/index.html
```

Mac OSX

```bash
open coverage/index.html
```

## Credits

[Rails Composer](https://github.com/RailsApps/rails-composer) was used to
quickly configure this application. Configuration information can be seen
in the git log.
