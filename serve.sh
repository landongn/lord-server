#!/bin/bash
elixir --detached -e "File.write! 'pid', :os.getpid" -S mix phoenix.server && cat pid