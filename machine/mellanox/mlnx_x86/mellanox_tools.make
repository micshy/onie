#-------------------------------------------------------------------------------
#
#
#-------------------------------------------------------------------------------
#
# This is a makefile fragment that defines the build of Mellanox bsp tools
#

MELLANOX_TOOLS_BUILD_DIR		= $(MBUILDDIR)/mellanox_tools
MELLANOX_TOOLS_SOURCE_DIR		= $(MACHINEDIR)/mellanox_tools
MELLANOX_TOOLS_DIR			= $(MELLANOX_TOOLS_BUILD_DIR)
MELLANOX_TOOLS_INSTALL_STAMP	= $(STAMPDIR)/mellanox_tools-install
MELLANOX_TOOLS_STAMP		= \
				  $(MELLANOX_TOOLS_INSTALL_STAMP)

PHONY += mellanox_tools \
	 mellanox_tools-install mellanox_tools-clean

mellanox_tools: $(MELLANOX_TOOLS_STAMP)

$(MELLANOX_TOOLS_DIR):
	mkdir -p $@

ifndef MAKE_CLEAN
MELLANOX_TOOLS_NEW_FILES = $(shell test -d $(MELLANOX_TOOLS_DIR) && test -f $(MELLANOX_TOOLS_BUILD_STAMP) && \
	              find -L $(MELLANOX_TOOLS_DIR) -newer $(MELLANOX_TOOLS_BUILD_STAMP) -type f \
			\! -name symlinks \! -name symlinks.o -print -quit)
endif

mellanox_tools-install: $(MELLANOX_TOOLS_INSTALL_STAMP)
$(MELLANOX_TOOLS_INSTALL_STAMP): $(SYSROOT_INIT_STAMP) $(DEV_SYSROOT_INIT_STAMP) $(MELLANOX_TOOLS_KERNEL_INSTALL_STAMP)
	$(Q) echo "==== Installing mellanox_tools in $(SYSROOTDIR) ===="
	$(Q) cp -v $(MELLANOX_TOOLS_SOURCE_DIR)/* $(SYSROOTDIR)/usr/bin
	$(Q) touch $@

USERSPACE_CLEAN += mellanox_tools-clean
mellanox_tools-clean:
	$(Q) rm -rf $(MELLANOX_TOOLS_BUILD_DIR)
	$(Q) rm -f $(MELLANOX_TOOLS_STAMP)
	$(Q) echo "=== Finished making $@ for $(PLATFORM)"

PACKAGES_INSTALL_STAMPS += $(MELLANOX_TOOLS_INSTALL_STAMP)
#-------------------------------------------------------------------------------
#
# Local Variables:
# mode: makefile-gmake
# End:
