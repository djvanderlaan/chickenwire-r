.PHONY: copy_lib document clean

lib_headers= $(notdir $(wildcard chickenwire/include/*.h))
lib_source= $(notdir $(wildcard chickenwire/src/*.cpp))

copy_lib: $(addprefix chickenwire/include/, $(lib_headers)) $(addprefix, include/, $(lib_source))
	cp $(addprefix chickenwire/include/, $(lib_headers)) src/
	cp $(addprefix chickenwire/src/, $(lib_source)) src/

clean:
	rm -f $(addprefix src/, $(lib_headers)) $(addprefix src/, $(lib_source)) 

document:
	Rscript  -e "roxygen2::roxygenise()"


test: 
	for file in tests/test*; do \
	  Rscript -e "devtools::load_all(); source('$$file')";\
	done

