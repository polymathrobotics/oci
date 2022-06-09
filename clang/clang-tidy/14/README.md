# clang-tidy ![clang-tidy](https://github.com/polymathrobotics/oci/actions/workflows/clang-tidy-push.yml/badge.svg) 

Based on:
https://clang.llvm.org/docs/ClangFormat.html

clang-format is a standalone tool that can be use to format
C/C++/Java/JavaScript/JSON/Objective-C/Protobuf/C# code.

DockerHub: https://hub.docker.com/r/polymathrobotics/clang-format

## Using the image

```
docker pull polymathrobotics/clang-format:14.0.4
docker run -it --rm \
  -v "$(pwd)":/src \
  polymathrobotics/clang-format:14.0.4
```

Command-line help:

```
% docker run -it --rm polymathrobotics/clang-tidy --help

# clang-tidy --help
USAGE: clang-tidy [options] <source0> [... <sourceN>]

OPTIONS:

Generic Options:

  --help                         - Display available options (--help-hidden for more)
  --help-list                    - Display list of available options (--help-list-hidden for more)
  --version                      - Display the version of this program

clang-tidy options:

  --checks=<string>              -
                                   Comma-separated list of globs with optional '-'
                                   prefix. Globs are processed in order of
                                   appearance in the list. Globs without '-'
                                   prefix add checks with matching names to the
                                   set, globs with the '-' prefix remove checks
                                   with matching names from the set of enabled
                                   checks. This option's value is appended to the
                                   value of the 'Checks' option in .clang-tidy
                                   file, if any.
  --config=<string>              -
                                   Specifies a configuration in YAML/JSON format:
                                     -config="{Checks: '*',
                                               CheckOptions: [{key: x,
                                                               value: y}]}"
                                   When the value is empty, clang-tidy will
                                   attempt to find a file named .clang-tidy for
                                   each source file in its parent directories.
  --config-file=<string>         -
                                   Specify the path of .clang-tidy or custom config file:
                                    e.g. --config-file=/some/path/myTidyConfigFile
                                   This option internally works exactly the same way as
                                    --config option after reading specified config file.
                                   Use either --config-file or --config, not both.
  --dump-config                  -
                                   Dumps configuration in the YAML format to
                                   stdout. This option can be used along with a
                                   file name (and '--' if the file is outside of a
                                   project with configured compilation database).
                                   The configuration used for this file will be
                                   printed.
                                   Use along with -checks=* to include
                                   configuration of all checks.
  --enable-check-profile         -
                                   Enable per-check timing profiles, and print a
                                   report to stderr.
  --explain-config               -
                                   For each enabled check explains, where it is
                                   enabled, i.e. in clang-tidy binary, command
                                   line or a specific configuration file.
  --export-fixes=<filename>      -
                                   YAML file to store suggested fixes in. The
                                   stored fixes can be applied to the input source
                                   code with clang-apply-replacements.
  --extra-arg=<string>           - Additional argument to append to the compiler command line
  --extra-arg-before=<string>    - Additional argument to prepend to the compiler command line
  --fix                          -
                                   Apply suggested fixes. Without -fix-errors
                                   clang-tidy will bail out if any compilation
                                   errors were found.
  --fix-errors                   -
                                   Apply suggested fixes even if compilation
                                   errors were found. If compiler errors have
                                   attached fix-its, clang-tidy will apply them as
                                   well.
  --fix-notes                    -
                                   If a warning has no fix, but a single fix can
                                   be found through an associated diagnostic note,
                                   apply the fix.
                                   Specifying this flag will implicitly enable the
                                   '--fix' flag.
  --format-style=<string>        -
                                   Style for formatting code around applied fixes:
                                     - 'none' (default) turns off formatting
                                     - 'file' (literally 'file', not a placeholder)
                                       uses .clang-format file in the closest parent
                                       directory
                                     - '{ <json> }' specifies options inline, e.g.
                                       -format-style='{BasedOnStyle: llvm, IndentWidth: 8}'
                                     - 'llvm', 'google', 'webkit', 'mozilla'
                                   See clang-format documentation for the up-to-date
                                   information about formatting styles and options.
                                   This option overrides the 'FormatStyle` option in
                                   .clang-tidy file, if any.
  --header-filter=<string>       -
                                   Regular expression matching the names of the
                                   headers to output diagnostics from. Diagnostics
                                   from the main file of each translation unit are
                                   always displayed.
                                   Can be used together with -line-filter.
                                   This option overrides the 'HeaderFilterRegex'
                                   option in .clang-tidy file, if any.
  --line-filter=<string>         -
                                   List of files with line ranges to filter the
                                   warnings. Can be used together with
                                   -header-filter. The format of the list is a
                                   JSON array of objects:
                                     [
                                       {"name":"file1.cpp","lines":[[1,3],[5,7]]},
                                       {"name":"file2.h"}
                                     ]
  --list-checks                  -
                                   List all enabled checks and exit. Use with
                                   -checks=* to list all available checks.
  --load=<pluginfilename>        - Load the specified plugin
  -p=<string>                    - Build path
  --quiet                        -
                                   Run clang-tidy in quiet mode. This suppresses
                                   printing statistics about ignored warnings and
                                   warnings treated as errors if the respective
                                   options are specified.
  --store-check-profile=<prefix> -
                                   By default reports are printed in tabulated
                                   format to stderr. When this option is passed,
                                   these per-TU profiles are instead stored as JSON.
  --system-headers               - Display the errors from system headers.
  --use-color                    -
                                   Use colors in diagnostics. If not set, colors
                                   will be used if the terminal connected to
                                   standard output supports colors.
                                   This option overrides the 'UseColor' option in
                                   .clang-tidy file, if any.
  --vfsoverlay=<filename>        -
                                   Overlay the virtual filesystem described by file
                                   over the real file system.
  --warnings-as-errors=<string>  -
                                   Upgrades warnings to errors. Same format as
                                   '-checks'.
                                   This option's value is appended to the value of
                                   the 'WarningsAsErrors' option in .clang-tidy
                                   file, if any.

-p <build-path> is used to read a compile command database.

	For example, it can be a CMake build directory in which a file named
	compile_commands.json exists (use -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
	CMake option to get this output). When no build path is specified,
	a search for compile_commands.json will be attempted through all
	parent paths of the first input file . See:
	https://clang.llvm.org/docs/HowToSetupToolingForLLVM.html for an
	example of setting up Clang Tooling on a source tree.

<source0> ... specify the paths of source files. These paths are
	looked up in the compile command database. If the path of a file is
	absolute, it needs to point into CMake's source tree. If the path is
	relative, the current working directory needs to be in the CMake
	source tree and the file must be in a subdirectory of the current
	working directory. "./" prefixes in the relative files will be
	automatically removed, but the rest of a relative path must be a
	suffix of a path in the compile command database.


Configuration files:
  clang-tidy attempts to read configuration for each source file from a
  .clang-tidy file located in the closest parent directory of the source
  file. If InheritParentConfig is true in a config file, the configuration file
  in the parent directory (if any exists) will be taken and current config file
  will be applied on top of the parent one. If any configuration options have
  a corresponding command-line option, command-line option takes precedence.
  The effective configuration can be inspected using -dump-config:

    $ clang-tidy -dump-config
    ---
    Checks:              '-*,some-check'
    WarningsAsErrors:    ''
    HeaderFilterRegex:   ''
    FormatStyle:         none
    InheritParentConfig: true
    User:                user
    CheckOptions:
      - key:             some-check.SomeOption
        value:           'some value'
    ...
```
