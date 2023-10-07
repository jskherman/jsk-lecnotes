# README

This is a lecture notes template that uses Typst to generate a PDF document. This is based off of [Sara Venkatraman](https://github.com/sara-venkatraman)'s [lecture notes template in LaTeX](https://github.com/sara-venkatraman/LaTeX-Templates#lecture-notes).

There are some custom functions that are defined in the [`template.typ`](./template.typ) file that are used to add some markup. Additionally, here is [a link to Typst snippets files for VS Code and Vim/Neovim](https://www.jskherman.com/blog/typst-snippets/) that I converted from [Gilles Castel's LaTeX snippets](https://castel.dev/post/lecture-notes-1/) to make writing math in Typst more convenient.

## Preview



## Usage

1. Download a copy of the [`template.typ`](./template.typ) file and [`example.typ`](./example.typ) in [Releases](https://github.com/jskherman/jsk-lecnotes/releases/).
2. Copy these files to your project's root directory.
3. Rename and customize the `example.typ` file to get started using the template.

### Notes

> **Warning**
>
> If you plan to split your document into multiple files for organization, you may need to add `#import "template.typ": *` to the top of each file for certain functions to work such as `blockquote()` or `iboxed()`.
>
> For example, assuming you have a `./content/chapter.typ` file and a `./template.typ` file at the project root, you would need to add `#import "../template.typ": *` to the top of the file.
