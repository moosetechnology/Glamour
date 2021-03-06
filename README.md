# Glamour

Glamour is an engine for building browsers used in the [Moose](http://moosetechnology.org) analysis platform.

Glamour is present by default in both Pharo 6 and Pharo 7. To update Glamour to the latest version you can use the following scripts:

*Pharo 7*
```
Metacello new
   baseline: 'Glamour';
   repository: 'github://moosetechnology/glamour/src';
   load.
```

*Pharo 6*
```
Metacello new
   baseline: 'Glamour';
   repository: 'github://moosetechnology/glamour:pharo6/src';
   load.
```

If you depend on Glamour in your configuration add a baseline dependency to `github://moosetechnology/glamour:pharo6/src` for *Pharo 6* and to `github://moosetechnology/glamour/src` for Pharo 7.
