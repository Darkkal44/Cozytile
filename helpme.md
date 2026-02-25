
# ───────────────────────────────────────────────────────────────#
#                     Troubleshooting Guide                      #
# ───────────────────────────────────────────────────────────────#

If you've encountered an issue during the setup process, please refer to the following common errors and their solutions.

# ───────────────────────────────────────────────────────────────#
#                     Common Errors & Fixes                      #
# ───────────────────────────────────────────────────────────────#

Error 1: Paru fails due to missing libalpm.so.14

- ERROR:  
  paru: error while loading shared libraries: libalpm.so.14: cannot open shared object file: No such file or directory

- FIX:  
  You can fix this by creating a symbolic link to the newer version of the library:

  COMMAND:
  sudo ln -s /usr/lib/libalpm.so.15.0.0 /usr/lib/libalpm.so.14

# ───────────────────────────────────────────────────────────────#
#                              Note                              #
# ───────────────────────────────────────────────────────────────#

If you encounter an error that isn't listed here, please open an issue at the GitHub repository. Even if you know the fix, it would be great if you let us know to help others!
Thank you!!
