vpath %.sfd src

include version.mk

all : regular bold italic bolditalic

regular : Junicode.ttf

bold : Junicode-Bold.ttf

italic : Junicode-Italic.ttf

bolditalic : Junicode-BoldItalic.ttf

woff : Junicode.ttf Junicode-Italic.ttf Junicode-Bold.ttf Junicode-BoldItalic.ttf
	which sfnt2woff > /dev/null; \
	if [ $$? -eq 0 ] ; then \
	  sfnt2woff Junicode.ttf ; \
	  sfnt2woff Junicode-Italic.ttf ; \
	  sfnt2woff Junicode-Bold.ttf ; \
	  sfnt2woff Junicode-BoldItalic.ttf ; \
	else \
	  echo "sfnt2woff is not installed." ; \
	fi

Junicode.ttf : Junicode-Regular.sfd
	which ttfautohint > /dev/null ; \
	if [ $$? -eq 0 ] ; then \
	  python util/simplegen.py src/Junicode-Regular.sfd jr-tmp.ttf $(TARGET_SYS) ; \
	  ttfautohint -f -l 20 -r 150 -v jr-tmp.ttf Junicode.ttf ; \
	  rm jr-tmp.ttf ; \
	else \
	  python util/simplegen.py src/Junicode-Regular.sfd Junicode.ttf ; \
	fi

Junicode-Bold.ttf : Junicode-Bold.sfd
	which ttfautohint > /dev/null ; \
	if [ $$? -eq 0 ] ; then \
	  python util/simplegen.py src/Junicode-Bold.sfd jb-tmp.ttf ; \
	  ttfautohint -f -l 20 -r 150 -v jb-tmp.ttf Junicode-Bold.ttf ; \
	  rm jb-tmp.ttf ; \
	else \
	  python util/simplegen.py src/Junicode-Bold.sfd Junicode-Bold.ttf ; \
	fi

Junicode-Italic.ttf : Junicode-Italic.sfd
	which ttfautohint > /dev/null ; \
	if [ $$? -eq 0 ] ; then \
	  python util/simplegen.py src/Junicode-Italic.sfd ji-tmp.ttf ; \
	  ttfautohint -f -l 20 -r 150 -v ji-tmp.ttf Junicode-Italic.ttf ; \
	  rm ji-tmp.ttf ; \
	else \
	  python util/simplegen.py src/Junicode-Italic.sfd Junicode-Italic.ttf ; \
	fi

Junicode-BoldItalic.ttf : Junicode-BoldItalic.sfd
	which ttfautohint > /dev/null ; \
	if [ $$? -eq 0 ] ; then \
	  python util/simplegen.py src/Junicode-BoldItalic.sfd jbi-tmp.ttf ; \
	  ttfautohint -f -l 20 -r 150 -v jbi-tmp.ttf Junicode-BoldItalic.ttf ; \
	  rm jbi-tmp.ttf ; \
	else \
	  python util/simplegen.py src/Junicode-BoldItalic.sfd Junicode-BoldItalic.ttf ; \
	fi

clean :
	rm -f *.ttf ; rm -f xgridfit/*.py ; rm -f *.woff

dist :
	$(MAKE) -f Makefile clean
	tar -C .. -zcvf $(PACKAGE)-$(VERSION).tar.gz \
	  --exclude=*.tar.bz2 --exclude=.* \
	  --exclude=*~ --exclude=*.tar.gz $(PACKAGE)
