OUTPUTDIR=public

.PHONY : all clean serve build deploy zip_projects pdf_slides

all: build pdf_slides


# Slides to PDF -----------------------------------------------------------
TO_PDF = $(wildcard static/slides/*.html)
PDF_TARGETS_FULL = $(addsuffix .pdf,$(basename $(TO_PDF)))
PDF_TARGETS = $(filter-out static/slides/14-slides.pdf, $(PDF_TARGETS_FULL))

static/slides/%.pdf: static/slides/%.html
	Rscript -e "xaringanBuilder::build_pdf("blogdown::build_site(build_rmd = blogdown::filter_md5sum)" $@

pdf_slides: $(PDF_TARGETS)


# Site building -----------------------------------------------------------
clean:
	rm -rf public/

static/slides/css/ath-slides.css:
	sass static/slides/css/ath-slides.scss > static/slides/css/ath-slides.css

# build: 
build: static/slides/css/ath-slides.css pdf_slides
	Rscript -e "blogdown::build_site(build_rmd = blogdown::filter_md5sum)"

serve: build
	Rscript -e "blogdown::serve_site(port=4321)"

deploy: build
	rsync -Prvzc --exclude='.Rproj.user/' --delete $(OUTPUTDIR)/ $(SSH_TARGET)
