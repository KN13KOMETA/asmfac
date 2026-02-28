.PHONY = run clean

objects = fac.o

$(objects): %.o: %.a
	as $< -o $@

fac: $(objects)
	gcc $< -o $@ -nostdlib -static

run: fac
	./$<

clean:
	rm -f fac $(objects)
