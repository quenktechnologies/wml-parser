
lib: $(shell find src -type f -name \*.ts) src/parser.js
	rm -R lib || true 
	cp -R -u src lib
	./node_modules/.bin/tsc --project lib

src/parser.js: src/wml.y
	./node_modules/.bin/jison -o $@ src/wml.y 

.PHONY: docs
docs: lib
	./node_modules/.bin/typedoc \
	--mode modules \
	--out $@ \
	--tsconfig lib/tsconfig.json \
	--theme minimal lib  \
	--excludeNotExported \
	--excludePrivate && \
	echo "" > docs/.nojekyll
