# Harbor Studio qualification

Experimental native Windows paint/vector host, 2026-11-13.

- Optimized Windows release build passed.
- Scoped formatting and strict all-target Clippy passed.
- The standalone launcher installer/updater is excluded from the native host entry point.
- Preferences use HarborStudioData beside the executable, or HARBOR_STUDIO_CONFIG_DIR.

Scope: PNG, JPEG and .pcraft opening; New painting; Paint/Vector switching; native vector content embedded in the .pcraft project. This is a two-dimensional prototype, not a complete universal or 3D canvas. Some standalone editor platform services are unavailable in the host. Save projects explicitly; do not assume full standalone autosave/recovery parity.

Only the native Windows host is being qualified. Legacy upstream installers and web launcher are not Harbor distributions. Optional Arabic and Thai font faces were unavailable in the selected font checkout. No signed installer or production release is claimed.

Validation: all five active native host tests passed (one manual performance test ignored), covering a new painting, editable vector insertion, native-data/depth save/reopen, undo, preview revision safety and actual offscreen editor input. Both editor screenshots were visually inspected. No live desktop launch was performed for this host.
