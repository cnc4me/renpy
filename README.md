# RenPy
A custom syntax and interpreter for giving more context to Fanuc Macro B programs.


## Variable Substitutions
All system macro variables will be substituted automatically if the sub was used as a G65 call. Each letter is already mapped to the corresponding number.

If your calling NC program has ```G65 P1234 A2.3```, the withing the ```1234``` macro, ```#1``` would be ```2.3```
For simplicity, you can use the letters instead of trying to remember that ```#1``` was ```A``` or that ```#21``` is ```U```

You can also create a labeled variable instead of just letters, to give more context to the macro. To define variable substitutions, insert them before the leading ```%``` of the program. In the following example, we have given names to some of the variables that Renishaw uses for probing results. We have also given context to the letter variables by giving them a name.

## Example
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