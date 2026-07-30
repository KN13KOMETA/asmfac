.PHONY: run clean freshrun

objects = src/start.o

$(objects): %.o: %.s
	as $< -o $@

fac: $(objects)
	ld $^ -o $@ -static
	# gcc $^ -o $@ -nostdlib -static

run: fac
	./$<

freshrun: clean run

clean:
	rm -f fac $(objects)
