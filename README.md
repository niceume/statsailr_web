# StatSailr Web

This program enables access to [StatSailr](https://github.com/niceume/statsailr) from your browser. Using [Sinatra](http://sinatrarb.com/) web framework, web interface to StatSailr is provided.


Tutorials and documents for StatSailr are available on the [official StatSailr website](https://statsailr.io).


## Install

### Requirements

1. R
    + Ver. 3.5 or higher (For Windows, Ver. 4.1 or higher is highly recommended.)
        + For Windows, binary installer is [provied](https://cran.r-project.org/bin/windows/base/).
        + On Unix, R package name is usually "r-base" or "R-core".
2. R packages
    + Packages need to be installed from R interpreter: install.packages("datasailr", "Cairo", "png", "jpeg")
        + On Windows, binary packges are installed, and there is no need to compile them.
        + On Unix, source packages are installed, which require build process.
            + C compilers and basic tools. (The package name is usually 'build-essential')
            + R's C header files is required. ( The package name is usually "r-base-dev" or "R-core-devel" )
            + Header files for Cairo. Package names differ on systems ("libcairo2-dev" or "cairo-devel"). Please see https://www.cairographics.org/download/
            + Header file of X11/Intrinsic.h is required. Package names differ on systems ("libxt-dev" or "libXt-devel")
3. Environment/System Variables for R
    + Setup dynamic (shared) library path to libR.so on Unix or R.dll on Windows.
        + On Windows, set 'RUBY_DLL_PATH' system variable.
        + On Unix, set 'LD_LIBRARY_PATH' environment variable.
    + Set 'R_HOME' system/environment variable.
        + On Unix, it needs to be set. What value should be specified here can be obtained by Sys.getenv("R_HOME") in R interpreter.
            + (e.g.) export R_HOME=/usr/lib/R
            + (e.g.) export R_HOME=/usr/lib64/R
2. Ruby
    + Ver.2.7 or Ver.3.0 or higher
        + On Windows, use RubyInstaller and Devkit. (https://rubyinstaller.org/downloads/)
        + On Unix, usually package name is 'ruby'.
            + ruby.h is required when installing gems, which can be installed via system packages. ("ruby-dev" or "ruby-devel")
    + Recent versions of Ruby come with Bundler (which provides 'bundle' command).
        + If 'bundle' command is not available, install it with '(sudo) gem install bundler'.
3. git



### Install & Start StatSailr Web

* Install

```
git clone https://github.com/niceume/statsailr_web.git
cd statsailr_web
bundle config set --local path 'vendor/bundle'
bundle install
```

* Start

```
bundle exec rackup
```

or you can deploy the application using Ruby application servers, such as Phusion Passenger.


## Additional Notes

This application can be deployed using Phusion Passenger. At this time, environment variables need to be set system wide or need to be set for web servers.

See ldconfig manual or use SetEnv directive for Apache.


## License

The program is available as open source under the terms of the [GPL v3 License](https://www.gnu.org/licenses/gpl-3.0.en.html).


## Contact

Your feedback is welcome.

Maintainer: Toshi Umehara toshi@niceume.com
