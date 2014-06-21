# This just shortcuts stuff through to cmake
all build ctwm install clean: build/Makefile
	( cd build && ${MAKE} ${@} )

build/Makefile cmake: CMakeLists.txt
	( cd build && \
		cmake -DCMAKE_C_FLAGS:STRING="${CFLAGS}" ${CMAKE_EXTRAS} .. )

allclean distclean:
	rm -rf build/*


# Reindent files
indent:
	astyle -n --options=ctwm.astyle *.h *.c

# Prebuild these files for releases
YACC?=/usr/bin/yacc
YFLAGS=-d -b gram
RELEASE_FILES=gram.tab.c gram.tab.h lex.c

release_files: ${RELEASE_FILES}
release_clean:
	rm -f ${RELEASE_FILES}

gram.tab.c: gram.tab.h
gram.tab.h: gram.y
	${YACC} ${YFLAGS} gram.y

# Standard make transformations give us lex.c
