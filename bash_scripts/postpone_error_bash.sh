#!/bin/bash
#works properly if COMMAND takes time and it would be not instantaneous.
COMMAND && RC=$? || RC=$?
echo "do stuff even if the command before fails, then read the output of the previous command"
exit $RC
