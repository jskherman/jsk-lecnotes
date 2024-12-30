# README

This is a lecture notes template that uses Typst to generate a PDF document. This is based off of [Sara Venkatraman](https://github.com/sara-venkatraman)'s [lecture notes template in LaTeX](https://github.com/sara-venkatraman/LaTeX-Templates#lecture-notes).

There are some custom functions that are defined in the [`lib.typ`](./lib.typ) file that are used to add some markup. Additionally, here is [a link to Typst snippets files for VS Code and Vim/Neovim](https://www.jskherman.com/blog/typst-snippets/) converted from [Gilles Castel's LaTeX snippets](https://castel.dev/post/lecture-notes-1/) to make writing math in Typst more convenient.

## Preview

See [example PDF](https://github.com/jskherman/jsk-lecnotes/releases/latest/download/example.pdf) in the Releases section.

<a href="https://github.com/jskherman/jsk-lecnotes/releases/latest/download/example.pdf">
<img src="https://github.com/jskherman/jsk-lecnotes/assets/68434444/670d66c6-377b-4eea-bb6d-38ace128a66e" width="400"/>
<img src="https://github.com/jskherman/jsk-lecnotes/assets/68434444/1eb03907-80c8-4803-8cf8-c23141b0938c" width="400"/>
</a>

## Usage

1. Download a copy of the [`lib.typ`](./lib.typ) file and [`example.typ`](./example.typ).
2. Copy these files to your project's root directory.
3. Rename `example.typ` to `main.typ` and customize it to get started using the template.

### Notes

> [!Warning]
> If you plan to split your document into multiple files for organization, you may need to add `#import "/lib.typ": *` to the top of each file for certain functions to work such as `blockquote()` or `iboxed()`.
>
> For example, assuming you have a `/content/chapter1.typ` file and a `/lib.typ` file at the project root, you would need to add `#import "/lib.typ": *` to the top of the chapter file.
