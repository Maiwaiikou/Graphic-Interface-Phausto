## Install

The project can be loaded via Metacello by copy/paste this script : 

```smalltalk
EpMonitor disableDuring: [
    Metacello new
        baseline: 'PharoJamSession';
        repository: 'github://Maiwaiikou/PharoJamSession';
            onConflict: [ :ex | ex useIncoming ];
            onUpgrade: [ :ex | ex useIncoming ];
        load].
```

## Launch the project

```smalltalk
Interface new open.
```