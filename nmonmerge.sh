#!/bin/sh

################################################################################
# Copyright 2019, Russell Adams <Russell.Adams@AdamsSystems.nl>
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

######################################################################################
# Merges multiple NMON files into a single NMON file for use with tools like nmonchart
# Prints the new file to STDOUT, be sure to redirect the output
# Uses the headers from the first file ONLY, disk names and adapters might not match


# Print first file headers, stop at the first timestamp
awk 'BEGIN {p=1} ; /^ZZZZ/ {p=0} ; p {print $0}' "$1"

# Process all files, dynamically replacing all the timestamps into a new series
awk 'BEGIN {FS=OFS="," ; curr=0} ;
     $1 == "ZZZZ" {curr+=1} ;
     $2 ~ "^T[0-9]{4}" {print $1, sprintf("T%04d",curr), substr($0, index($0,$3))}' \
    "$@"
