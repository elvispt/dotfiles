CHANGELOG
----------

All changes to dotfiles are written here.

## [1.1.0] 2017-11-22

### Added

- cext: `cext <EXTENSION>` Counts the number of files, of the given extension, inside the current directory, recursively.

## [1.0.0] 2017-10-17

### Added

- ssh connection script
    - scon: `scon sa` Will connecto to the server defined for "sa".
- git flow feature shortcut scripts
    - fstart: `fstart <FEATURE_NAME>´. Will create a new branch on feature/<FEATURE_NAME>.
    - fpub: `fpub` Need to be on a feature branch. Will push then change to develop.
- fh: `fh <TEXT>` Will search on command history for the text and show it on the screen.
- gt: `gt code` Will cd into directory defined. Useful for cd'ng to common locations.
- Alias for listing running and stopped docker containers.
