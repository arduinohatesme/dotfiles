#!/usr/bin/env fish

if not test -d ./lua/ign/
    mkdir ./lua/ign/
end

cp ./lua/extras/* ./lua/ign/
