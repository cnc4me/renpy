All system macro variables will be substituted automatically if the sub was used as a G65 call. Each letter is already mapped to the corresponding number. For example:

If your calling NC program has ```G65 P1234 A2.3```, the withing the ```1234``` macro, ```#1``` would be ```2.3```
For simplicity, you can use the letters instead of trying to remember that ```#1``` was ```A``` or that ```#21``` is ```U```

To define variable substitutions, start your NC file with the definitions.

```
#X_ERROR     : #140
#Y_ERROR     : #141
#Z_ERROR     : #142
#ERROR_FLAG  : #148
#PROBE_DEPTH : #600
#X_SHIFT     : #U
#Y_SHIFT     : #V
#X_ERROR     : #A
#Y_ERROR     : #B
#Z_ERROR     : #C
%
O1234(EXAMPLE)
...
```