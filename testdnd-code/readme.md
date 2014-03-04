Drag and drop test code

> Y2010 - John B. Silvestri

This code was a beta test for successful production code that followed.

Usage: Drag a file onto testdnd.bat and it will execute testdnd.pl, passing the dragged file as a command argument.
This will take the original file "foo.txt" and cause the Perl code to create an output file "foo.addrs.txt".  That output will append a tab charater and the string "FOO" to each line in output file.  In production, this code would look up the e-mail address for each line in the source file and append it in the output.

Extra tidbit: The %~dp0 present in the .bat file tells the Windows command interpreter the drive and path to the .pl file; without this, Perl would be unable to locate the source code (you can see in it Explorer, but it would probably execute with a working directory of C:\WINDOWS or %SYSTEM32).
