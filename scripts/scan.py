#! /usr/bin/python
import os
import subprocess

TranslationOpts=""
# TranslationOpts+="gcc -o test.o"
TranslationOpts+="-source 11 -cp build/install/vuln-grpc-java/lib/\*.jar -cp build/libs/vuln-grpc-java.jar"
# TranslationOpts+="mvn com.fortify.sca.plugins.maven:sca-maven-plugin:translate"
# TranslationOpts+="-python-version 3 -python-path /usr/lib/python3.8:/home/bruce/.local/lib/python3.8/site-packages"
# TranslationOpts+="-gopath", "/home/bruce/.go"
# TranslationOpts+="-rubygem-path /usr/local/lib/ruby/gems/3.1.0/gems"
TranslationOpts+=" -project-root sca_build"

ScanOpts=""
ScanOpts+=" -rules grpc-java.xml"
# ScanOpts+=" -Dcom.fortify.sca.DefaultAnalyzers=configuration"
# ScanOpts+=" -DRuleScriptDebugger=true -DScriptsToDebug=android_privilegewarnings"
# ScanOpts+=" -Ddf3.debug=taint.log"                                 # Dump taint log
# ScanOpts+=" -Dcom.fortify.sca.followImports=false"                 # Do not translate and analyze all libraries that you require in your code
# ScanOpts+=" -Ddebug.dump-nst"                                      # For debugging purposes dumps NST files between Phase 1 and Phase 2 of analysis.
# ScanOpts+=" -Ddebug.dump-cfg"                                      # For debugging purposes controls dumping Basic Block Graph to file.
# ScanOpts+=" -Ddebug.dump-raw-cfg"                                  # Dump the cfg which is not optimized by dead code elimination
# ScanOpts+=" -Ddebug.dump-ssi"                                      # For debugging purposes dump ssi graph.
# ScanOpts+=" -Ddebug.dump-cg"                                       # For debugging purposes dump call graph.
# ScanOpts+=" -Ddebug.dump-vcg"                                      # For debugging purposes dump virtual call graph deferred items.
# ScanOpts+=" -Ddebug.dump-model"                                    # For debugging purposes data dump of model attributes.
# ScanOpts+=" -Ddebug.dump-call-targets"                             # For debugging purposes dump call targets for each call site
# ScanOpts+=" -Ddebug.dump-structural-tree"                          # Dumps the structural tree, Lots of output
# ScanOpts+=" -Dic.debug=issue_calculator.log"                       # Dump issue calculator log
# ScanOpts+=" -Dcom.fortify.sca.ThreadCount=1"                       # Disable multi-threading
# ScanOpts+=" -import-build-session <file>.mbs"                      # Import Mobile Build Session
ScanOpts+=" -project-root sca_build"
# ScanOpts+=" -Dcom.fortify.sca.debug.rule=5CD5DEF7,file_name.go,25" # Structural Debugger


BuildID = os.path.basename(os.getcwd())
Files="src build/generated/source/proto/main" 
ScanOpts+=f" -f {BuildID}.fpr"

clean_cmd=f"sourceanalyzer -b {BuildID} -clean && rm -rf trans.log scan.log trans_FortifySupport.log scan_FortifySupport.log sca_build"
print("+++ Cleaning the build...")
print("+++ "+clean_cmd)
print()
subprocess.run(clean_cmd, shell=True)

translate_cmd=f"sourceanalyzer -b {BuildID} {Files} -debug -verbose -logfile trans.log {TranslationOpts}"
print("+++ Translating...")
print("+++ "+translate_cmd)
print()
subprocess.run(translate_cmd, shell=True)
print()

scan_cmd=f"sourceanalyzer -b {BuildID} -scan -debug -verbose -logfile scan.log {ScanOpts}"
print("+++ Scanning...")
print("+++ "+scan_cmd)
print()
subprocess.run(scan_cmd, shell=True)
print()

subprocess.run(f"mv {BuildID}.fpr {os.environ['DOWNLOADS']}/.",shell=True)