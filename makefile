SHELL=/usr/bin/env bash

# ---------------------------------------------------------------------------- #

### Layout Configuration ###
PDF_DOC_DIR	= documents
SOURCE_DIR	= source
ASSET_DIR	= assets

### Compiler Configuration ###
TYP_COMPILER		 = typst
override TYP_FLAGS	+= --root .

# ---------------------------------------------------------------------------- #

#### Derived Variables ###
VOLUME_SRC_DIRS	= $(shell find $(SOURCE_DIR) -mindepth 1 -maxdepth 1 -type d)
VOLUME_NAMES	= $(foreach x,$(VOLUME_SRC_DIRS),$(shell basename $x))

### User Rules ###
.PHONY: all $(VOLUME_NAMES)

all: $(VOLUME_NAMES)
$(VOLUME_NAMES): %: $(PDF_DOC_DIR)/%.pdf

### Typst Source Build Rule...? ###
define DYN_RULE
$(PDF_DOC_DIR)/$1.pdf: \
$$(wildcard $(SOURCE_DIR)/*.typ) \
$$(wildcard $(SOURCE_DIR)/$1/*.typ)
	$(TYP_COMPILER) compile $(TYP_FLAGS) \
	$(SOURCE_DIR)/$1/$1.typ $$@
endef
$(foreach v,$(VOLUME_NAMES), \
	$(eval $(call DYN_RULE,$v)))
