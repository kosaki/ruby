#include "vm_opts.h"

provider ruby {
  probe method__entry(const char *classname, const char *methodname, const char *sourcefile, int sourceline);
  probe method__return(const char *classname, const char *methodname, const char *sourcefile, int sourceline);

  probe cmethod__entry(const char *classname, const char *methodname, const char *sourcefile, int sourceline);
  probe cmethod__return(const char *classname, const char *methodname, const char *sourcefile, int sourceline);

  probe require__entry(const char *filename, const char *sourcefile, int sourceline);
  probe require__return(const char *filename);

  probe find__require__entry(const char *filename, const char *sourcefile, int sourceline);
  probe find__require__return(const char *filename, const char *sourcefile, int sourceline);

  probe load__entry(const char *filename, const char *sourcefile, int sourceline);
  probe load__return(const char *filename);

  probe raise(const char *classname, const char *sourcefile, int sourceline);

  probe object__create(const char *classname, const char *sourcefile, int sourceline);
  probe array__create(long capacity, const char *sourcefile, int sourceline);
  probe hash__create(long size, const char *sourcefile, int sourceline);
  probe string__create(long length, const char *sourcefile, int sourceline);

  probe parse__begin(const char *sourcefile, int sourceline);
  probe parse__end(const char *sourcefile, int sourceline);

#if VM_COLLECT_USAGE_DETAILS
  probe insn(const char *insns_name);
  probe insn__operand(const char *val, const char *insns_name);
#endif

  probe gc__mark__begin();
  probe gc__mark__end();
  probe gc__sweep__begin();
  probe gc__sweep__end();
};

#pragma D attributes Stable/Evolving/Common provider ruby provider
#pragma D attributes Stable/Evolving/Common provider ruby module
#pragma D attributes Stable/Evolving/Common provider ruby function
#pragma D attributes Evolving/Evolving/Common provider ruby name
#pragma D attributes Evolving/Evolving/Common provider ruby args
