# Harbor Studio

Experimental native paint/vector shared-document host for Harbor Paint and Harbor Vector, maintained for @durtyrobbin.

The application opens directly into the editor. It does not run the original Craft app installer or updater. A painting and its embedded vector content share a viewport, with native vector data preserved inside .pcraft projects. New painting creates a canvas; the Paint and Vector buttons switch editors. Save project writes both native contents together.

## Build

Clone harbor-studio, harbor-paint and harbor-vector as sibling directories. Run `cargo build --release -p artcraft-launcher` here. The internal binary name is retained; the portable distribution calls it Harbor-Studio.exe. Open a PNG, JPEG or .pcraft file, or use New painting. Preferences and palette state use HarborStudioData beside the executable (or HARBOR_STUDIO_CONFIG_DIR).

This is an experimental shared host, not complete file-format or every-tool interoperability. The standalone Harbor Paint remains available for its full native application services.

## Provenance

Derived from craft-launcher shared-document-studio at e2bb914df0a03889f79879780402148739dce9e1. Original project: https://github.com/storytold/craft-launcher. History, original authorship and MIT/Apache notices are preserved. The original installer/updater entry path and trademark artwork are excluded from this application.

Development status: experimental source fork; Windows release compilation passed. See HARBOR-QUALIFICATION.md for validation and limitations. No signed installer or production release is claimed.
