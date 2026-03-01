.PHONY: run clean freshrun

objects = src/fac.o src/ztox.o

$(objects): %.o: %.a
	as $< -o $@

fac: $(objects)
	ld $^ -o $@ -static
	# gcc $^ -o $@ -nostdlib -static

run: fac
	./$<

freshrun: clean run

clean:
	rm -f fac $(objects)
