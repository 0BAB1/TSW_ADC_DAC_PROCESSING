# just to clean out all garbage from root

CLEAN_PATTERNS = *.jou *.log *.str *.runs *.sim *.ip_user_files *.Xil *.ltx *.wdb *.backup \
                 *.hw *.hwdef *.cache *.pb *.xpr *.db *.dcp *.bit *.vcd *.ila

.PHONY: clean

clean:
	@for pattern in $(CLEAN_PATTERNS); do \
	    if [ -e $$pattern ] || [ -d $$pattern ]; then \
	        echo "Removing $$pattern"; \
	        rm -rf $$pattern; \
	    fi \
	done
	rm -rf ./.Xil/
	@echo "done."
