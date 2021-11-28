OUTPUTDIR=public

.PHONY : all clean serve build deploy zip_projects pdf_slides

all: build pdf_slides


# Slides to PDF -----------------------------------------------------------
TO_PDF = $(wildcard static/slides/*.Rmd)
PDF_TARGETS = $(addsuffix .pdf, $(basename $(TO_PDF)))

# Compile slides

static/slides/%.pdf: static/slides/%.Rmd
	Rscript -e 'xaringanBuilder::build_pdf("$<", complex_slides = TRUE, keep_intermediates = TRUE)'
	
pdf_slides: $(PDF_TARGETS)


# Site building -----------------------------------------------------------
clean:
	rm -rf public/

# Create CSS
static/slides/css/ath-slides.css:
	sass static/slides/css/ath-slides.scss > static/slides/css/ath-slides.css

	
# Build site
build: static/slides/css/ath-slides.css pdf_slides
	Rscript -e "blogdown::build_site(build_rmd = blogdown::filter_md5sum)"

serve: build
	Rscript -e "blogdown::serve_site(port=4321)"

# deploy: build
# 	rsync -Prvzc --exclude='.Rproj.user/' --delete $(OUTPUTDIR)/ $(SSH_TARGET)
