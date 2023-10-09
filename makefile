.PHONY: watch

ifeq ($(OS),Windows_NT)
    # Windows
    watch:
	    @PowerShell -Command "typst watch example.typ --root ."
else
    # WSL or Unix-like system
    watch:
	    @bash -c "typst watch example.typ --root ."
endif
