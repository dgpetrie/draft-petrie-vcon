#!/bin/sh

awk 'BEGIN {max = 65}
    { 
      len = length($0); 
      if(len <= max) print $0;
      else 
      {
        match($0, /^ */);
        #print(RLENGTH " spaces")
        pref = RLENGTH + 2
        trunk = max; 
        start = 0; 
        prefix = 0; 
        while(start < len) 
        {
          # print(start, trunk);
          line_len = max - prefix
          if(line_len + start > len) line_len = len - start + 1
          printf("%*s%s\n", prefix, "", substr($0, start, line_len))
          #print(prefix substr($0, start, line_len));
          start = trunk;
          trunk = start + 1 + max - pref;
          prefix = pref
        }
      }
    }'

