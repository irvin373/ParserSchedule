#regular expresions
##this is the list of regular expresion with a descpiption of that

###Replace
``
/Horario de Clases.*/ => that is for clean this text that dont care us  and replace for none
/.Elaborado por el Centro.*/ => that is for clean this text that dont care us and replace for none
/Nivel.\w*/ => separe inecesary text from Carreer name and level and replace for none
/SisMat.*/ => replace head of tables and replace for none
``

###Separate
``
/(.Si encuentra).*\n/ => that is the expresion that select all the end of level of schedule
/\d/ => determinate a number
``