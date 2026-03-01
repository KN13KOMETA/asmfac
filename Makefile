.PHONY = run clean

objects = src/fac.o src/ztox.o

$(objects): %.o: %.a
	as $< -o $@

fac: $(objects)
	ld $< -o $@ -static
	# gcc $< -o $@ -nostdlib -static

run: fac
	./$<

clean:
	rm -f fac $(objects)
