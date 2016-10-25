#!/bin/sh

modMake () {
	file=$1
	sed -i 's/abspath /call mypath,/g' $file
	if ! grep "mypath=" $file
	then
		sed -i '/EMACS=/ a mypath=$(subst C:/,c:/,$(shell cygpath -m 
$(abspath $(1))))' $file
	else
		sed -i '/mypath=/ c mypath=$(subst C:/,c:/,$(shell cygpath -m 
$(abspath $(1))))' $file
	fi
}

echo "Modifying Makefile..."
for file in $(find . -name Makefile)
do
	echo "Modifying $file"
	modMake $file
done
echo "Done"

echo "Building..."
make
