dev:
	rstudio ./ &

c: clean

clean:
	rm -fr experiment.md experiment.html

l: libs

libs:
	find ./ -type f -name "*.Rmd" -exec grep  "library(" {} \; | sort -u | grep -Po '(?<=^library\()(.*?)(?=\))'

	@ # make l | tail -n +2 | grep -Po '(?<=^library\()(.*?)(?=\)$)'
