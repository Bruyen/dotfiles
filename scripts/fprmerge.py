#!/usr/bin/python3

import os
import sys
import getopt
import subprocess

# NOTE: I prefer to choose the expected file first in fzf
files=subprocess.check_output(['fzf', '-m']).decode("utf-8").splitlines()

def usage():
    print(files)
    print('Select 2 FPRs / FVDLs to compare')


def mergeFPRs(expected, actual):
    FPRUTLITY=os.path.expanduser("~") + "/SCA/Fortify_SCA_and_Apps_20.2.2/bin/FPRUtility"
    out=os.path.basename(os.path.splitext(expected)[0]) + "_MERGED.fpr"

    print("Selected files: " + str(files))
    print("expected: " + expected)
    print("actual: " + actual)
    print()
    print([FPRUTLITY, "-merge", "-project", expected, "-source", actual, "-f", out])
    print()
    subprocess.run([FPRUTLITY, "-merge", "-project", expected, "-source", actual, "-f", out])

    # NOTE: Move FPR to target directory
    target = "/mnt/c/Users/Dude/Downloads/."
    subprocess.run(["/usr/bin/mv", out, target])


if __name__ == "__main__":
    actualFile = ''

    try:
        opts, args = getopt.getopt(sys.argv[1:], "ha", ["help", "actual-file="])
    except getopt.GetoptError as err:
        print(err)
        usage()
        sys.exit(-1)

    for opt, arg in opts:
        if opt in("-h", "--help"):
            usage()
            sys.exit()
        elif opt in ("-a", "--actual-file"):
            actualFile = arg

    if len(files) == 2:
        project=files[0]
        source=files[1]
        mergeFPRs(project, source)
    elif len(files) == 1 and actualFile:
        project=files[0]
        mergeFPRs(project, actualFile)

        print()
        print("If everything looks good:")
        print()
        print("cp " + actualFile + " " + project)
