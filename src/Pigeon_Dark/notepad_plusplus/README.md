# Pigeon Dark for [Notepad++](https://notepad-plus-plus.org/)

A dark theme for [Notepad++](https://notepad-plus-plus.org/)

![Screenshot](./screenshot.png "Screenshot info: Notepad++ v7.9.1, Dec 26th, 2020.")

## Install

Notepad++ can customize via moving file to path `Notepad++/themes/` or using Notepad++ built-in `import` feature.

**Prerequisite**:

- Notepad++ installed
- File `PigeonDark.xml`
  - via wget:  

    ```powershell
    wget https://raw.githubusercontent.com/Moenupa/Pigeon/master/src/Pigeon_Dark/notepad_plusplus/PigeonDark.xml
    ```  

  - via clipboard: [PigeonDark.xml](./PigeonDark.xml)
- File `markdown.pigeondark.udl.xml` (Optional)
  - via wget:  

    ```powershell
    wget https://raw.githubusercontent.com/Moenupa/Pigeon/master/src/Pigeon_Dark/notepad_plusplus/markdown.pigeondark.udl.xml
    ```

  - via clipboard: [markdown.pigeondark.udl.xml](./markdown.pigeondark.udl.xml)

**Procedures**:

1. Go to path `%AppData%/Notepad++/themes`
1. Place `PigeonDark.xml` inside that folder
1. Restart Notepad++
1. PigeonDark will be available in `Settings` > `Style Configurator`

Alternative procedures

> 1. Notepad++ `Settings` > `Import` > `Import style theme(s)`  
> 1. Select downloaded Pigeon theme  
> 1. Restart Notepad++  
> 1. PigeonDark will be available in `Settings` > `Style Configurator`

**MarkDown Patcher**:

As `Pigeon Dark` is a dark theme which does not conforms pre-installed MarkDown syntax highlighting, moreover, Notepad++ does not support native markdown syntax highlighting, a patcher is provided to solve this.

1. place `markdown.pigeondark.udl.xml` inside folder `%AppData%/Notepad++/userDefineLangs`
1. Restart Notepad++
1. PigeonDark MarkDown patcher will be available in `Languages` > `MarkDown PigeonDark`

## Support

Pigeon Dark for Notepad++ Supports syntax highlighting of the following languages (or file extensions):

|ALPHA|LANGs|   |   |   |   |   |
|:---:|---|---|---|---|---|---|
|  A  | ASP | Assembly | AutoIt
|  B  | Batch |
|  C  | C | C++ | C# | CSS
|  D  | Diff |
|  H  | Haskell | HTML
|  I  | INI |
|  J  | Java |JavaScript|JSON
|  K  | KiXtart|
|  L  | LaTeX|LISP|Lua
|  M  | Makefile|Matlab
|  O  | Objective-C|
|  P  | Pascal|Perl|PHP|PowerShell|Properties|Python
|  R  | R|RC|Ruby|Rust
|  S  | SQL|
|  T  | TCL|TeX
|  V  | Visual Basic|
|  X  | XML|
|  Y  | YAML|

## License

MIT LICENSE
