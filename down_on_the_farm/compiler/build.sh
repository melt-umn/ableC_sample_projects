#!/bin/bash

# When grammars have simple names, such as 'compiler' used here, the name
# may be used by others.  Thus, the 'touch' below ensures that we don't
# re-use compilation results from another grammar with the same name.
touch CompilerSpec.sv

# We increase the stack and heap size for Ant so that Copper doesn't run
# out of memory when processing this grammar.  Since we have lexical
# ambiguities Copper uses a bit of memory to dump the parse table.
export ANT_OPTS="-Xss80M -Xmx4000M"


PATH_TO_ableC="../../../ableC"

PATH_TO_extensions="../../../extensions"

PATH_TO_tables="../../../ableC/extensions/conditional-tables"

PATH_TO_regex="../../../ableC/extensions/regex"
PATH_TO_closure="../../../ableC/extensions/closure"

#PATH_TO_gc="../../../ableC/extensions/gc"

#PATH_TO_string="../../../ableC/extensions/string"

silver -I ../ \
       -I $PATH_TO_ableC \
       -I $PATH_TO_extensions \
       -I $PATH_TO_tables \
       -I $PATH_TO_regex \
       -o ableC.jar $@ compiler

#       -I $PATH_TO_closure \
#       -I $PATH_TO_gc \
#       -I $PATH_TO_string \


rm -f build.xml
