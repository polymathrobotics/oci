# clang-format ![clang-format](https://github.com/polymathrobotics/oci/actions/workflows/clang-format-push.yml/badge.svg) 

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
% docker run -it --rm polymathrobotics/clang-format --help

OVERVIEW: A tool to format C/C++/Java/JavaScript/JSON/Objective-C/Protobuf/C# code.

If no arguments are specified, it formats the code from standard input
and writes the result to the standard output.
If <file>s are given, it reformats the files. If -i is specified
together with <file>s, the files are edited in-place. Otherwise, the
result is written to the standard output.

USAGE: clang-format [options] [<file> ...]

OPTIONS:

Clang-format options:

  --Werror                       - If set, changes formatting warnings to errors
  --Wno-error=<value>            - If set don't error out on the specified warning type.
    =unknown                     -   If set, unknown format options are only warned about.
                                     This can be used to enable formatting, even if the
                                     configuration contains unknown (newer) options.
                                     Use with caution, as this might lead to dramatically
                                     differing format depending on an option being
                                     supported or not.
  --assume-filename=<string>     - Override filename used to determine the language.
                                   When reading from stdin, clang-format assumes this
                                   filename to determine the language.
  --cursor=<uint>                - The position of the cursor when invoking
                                   clang-format from an editor integration
  --dry-run                      - If set, do not actually make the formatting changes
  --dump-config                  - Dump configuration options to stdout and exit.
                                   Can be used with -style option.
  --fallback-style=<string>      - The name of the predefined style used as a
                                   fallback in case clang-format is invoked with
                                   -style=file, but can not find the .clang-format
                                   file to use.
                                   Use -fallback-style=none to skip formatting.
  --ferror-limit=<uint>          - Set the maximum number of clang-format errors to emit before stopping (0 = no limit). Used only with --dry-run or -n
  --files=<string>               - Provide a list of files to run clang-format
  -i                             - Inplace edit <file>s, if specified.
  --length=<uint>                - Format a range of this length (in bytes).
                                   Multiple ranges can be formatted by specifying
                                   several -offset and -length pairs.
                                   When only a single -offset is specified without
                                   -length, clang-format will format up to the end
                                   of the file.
                                   Can only be used with one input file.
  --lines=<string>               - <start line>:<end line> - format a range of
                                   lines (both 1-based).
                                   Multiple ranges can be formatted by specifying
                                   several -lines arguments.
                                   Can't be used with -offset and -length.
                                   Can only be used with one input file.
  -n                             - Alias for --dry-run
  --offset=<uint>                - Format a range starting at this byte offset.
                                   Multiple ranges can be formatted by specifying
                                   several -offset and -length pairs.
                                   Can only be used with one input file.
  --output-replacements-xml      - Output replacements as XML.
  --qualifier-alignment=<string> - If set, overrides the qualifier alignment style determined by the QualifierAlignment style flag
  --sort-includes                - If set, overrides the include sorting behavior determined by the SortIncludes style flag
  --style=<string>               - Coding style, currently supports:
                                     LLVM, GNU, Google, Chromium, Microsoft, Mozilla, WebKit.
                                   Use -style=file to load style configuration from
                                   .clang-format file located in one of the parent
                                   directories of the source file (or current
                                   directory for stdin).
                                   Use -style=file:<format_file_path> to explicitly specifythe configuration file.
                                   Use -style="{key: value, ...}" to set specific
                                   parameters, e.g.:
                                     -style="{BasedOnStyle: llvm, IndentWidth: 8}"
  --verbose                      - If set, shows the list of processed files

Generic Options:

  --help                         - Display available options (--help-hidden for more)
  --help-list                    - Display list of available options (--help-list-hidden for more)
  --version                      - Display the version of this program
```

When the desired code formatting style is different from the available options, the style can be customized using the `-style="{key: value, ...}"` option or by putting your style configuration in the `.clang-format` or `_clang-format` file in your project’s directory and using `clang-format -style=file`.

An easy way to create the `.clang-format` file is:

```
clang-format -style=llvm -dump-config > .clang-format
```

Available style options are described in [Clang-Format Style Options](https://clang.llvm.org/docs/ClangFormatStyleOptions.html).

## CLion Integration

**clang-format** is integrated into [CLion](https://www.jetbrains.com/clion/) as an alternative code formatter. CLion turns it on automatically when there is a `.clang-format` file under the project root. Code style rules are applied as you type, including indentation, auto-completion, code generation, and refactorings.

**clang-format** can also be enabled without a `.clang-format` file. In this case, CLion prompts you to create one based on the current IDE settings or the default LLVM style.

## Visual Studio Code Integration

Get the latest Visual Studio Code extension from the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=xaver.clang-format). The default key-binding is Alt-Shift-F.

## Vim Integration

There is an integration for **vim** which lets you run the **clang-format** standalone tool on your current buffer, optionally selecting regions to reformat. The integration has the form of a *python*-file which can be found under *editorintegration/vim/clang-format.py*.

This can be integrated by adding the following to your *.vimrc*:

```
map <C-K> :py3f <path-to-this-file>/clang-format.py<cr>
imap <C-K> <c-o>:py3f <path-to-this-file>/clang-format.py<cr>
```

The first line enables **clang-format** for NORMAL and VISUAL mode, the second line adds support for INSERT mode. Change “C-K” to another binding if you need **clang-format** on a different key (C-K stands for Ctrl+k).

With this integration you can press the bound key and clang-format will format the current line in NORMAL and INSERT mode or the selected region in VISUAL mode. The line or region is extended to the next bigger syntactic entity.

It operates on the current, potentially unsaved buffer and does not create or save any files. To revert a formatting, just undo.

An alternative option is to format changes when saving a file and thus to have a zero-effort integration into the coding workflow. To do this, add this to your .vimrc:

```
function! Formatonsave()
  let l:formatdiff = 1
  py3f ~/llvm/tools/clang/tools/clang-format/clang-format.py
endfunction
autocmd BufWritePre *.h,*.cc,*.cpp call Formatonsave()
```

## Emacs Integration

Similar to the integration for **vim**, there is an integration for **emacs**. It can be found at *clang/tools/clang-format/clang-format.el* and used by adding this to your *.emacs*:

```
(load "<path-to-clang>/tools/clang-format/clang-format.el")
(global-set-key [C-M-tab] 'clang-format-region)
```

This binds the function *clang-format-region* to C-M-tab, which then formats the current line or selected region.
