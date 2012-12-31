#!/usr/bin/ruby
# -*- coding: us-ascii -*-

def set_argument (arg, nth)
  # remove C style type info
  arg.gsub!(/.+ (.+)/, '\1')

  # use user_string if arg is a pointer
  if (arg[0,1] == "*")
    "#{arg[1, 9999]} = user_string($arg#{nth})"
  else
    "#{arg} = $arg#{nth}"
  end
end

ruby_path = "./ruby"

text = ARGF.read

# remove preprocessor directives
text.gsub!(/^#.*$/, '')

# remove provider name
text.gsub!(/^provider ruby \{/, "")
text.gsub!(/^\};/, "")

# probename()
text.gsub!(/probe (.+)\( *\);/) {
  probe_name = $1
  probe = <<-End
    probe #{probe_name} = process("ruby").provider("ruby").mark("#{probe_name}")
    {
    }
  End
}

# probename(arg1)
text.gsub!(/ *probe (.+)\(([^,)]+)\);/) {
  probe_name = $1
  arg1 = $2

  probe = <<-End
    probe #{probe_name} = process("ruby").provider("ruby").mark("#{probe_name}")
    {
      #{set_argument(arg1, 1)}
    }
  End
}

# probename(arg1, arg2)
text.gsub!(/ *probe (.+)\(([^,)]+),([^,)]+)\);/) {
  probe_name = $1
  arg1 = $2
  arg2 = $3

  probe = <<-End
    probe #{probe_name} = process("#{ruby_path}").provider("ruby").mark("#{probe_name}")
    {
      #{set_argument(arg1, 1)}
      #{set_argument(arg2, 2)}
    }
  End
}

# probename(arg1, arg2, arg3)
text.gsub!(/ *probe (.+)\(([^,)]+),([^,)]+),([^,)]+)\);/) {
  probe_name = $1
  arg1 = $2
  arg2 = $3
  arg3 = $4

  probe = <<-End
    probe #{probe_name} = process("#{ruby_path}").provider("ruby").mark("#{probe_name}")
    {
      #{set_argument(arg1, 1)}
      #{set_argument(arg2, 2)}
      #{set_argument(arg3, 3)}
    }
  End
}

# probename(arg1, arg2, arg3, arg4)
text.gsub!(/ *probe (.+)\(([^,)]+),([^,)]+),([^,)]+),([^,)]+)\);/) {
  probe_name = $1
  arg1 = $2
  arg2 = $3
  arg3 = $4
  arg4 = $5

  probe = <<-End
    probe #{probe_name} = process("#{ruby_path}").provider("ruby").mark("#{probe_name}")
    {
      #{set_argument(arg1, 1)}
      #{set_argument(arg2, 2)}
      #{set_argument(arg3, 3)}
      #{set_argument(arg4, 4)}
    }
  End
}

print text

