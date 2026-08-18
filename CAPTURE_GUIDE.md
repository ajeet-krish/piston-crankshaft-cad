# Fusion 360 Capture Guide

Step-by-step reference for recording and exporting all visual assets from Fusion 360.
Every section maps directly to a deliverable in the portfolio README.

---

## A. Turntable Rotation Animation

**Purpose:** Hero animation for the README and portfolio landing page.

### Fusion 360 Steps

1. Open the full assembly (`crankshaft_assembly.f3d`).
2. Switch to the **Animation** workspace (top toolbar, right of Design).
3. Click **Create Animation** > **Turntable**.
4. In the Turntable dialog:
   - **Selection:** Click the assembly root in the browser tree (selects everything).
   - **Axis:** Z-axis (vertical).
   - **Direction:** Clockwise.
   - **Rotation:** 360 degrees.
   - **Duration:** 8 seconds.
5. Click **OK** to generate the timeline.

### Camera Setup

1. Before recording, orient the viewport:
   - Hold **Shift + Middle Mouse** to orbit to a standard isometric angle.
   - Target elevation: approximately 30 degrees above the horizontal plane.
   - The crankshaft axis should run left-to-right across the screen.
2. Right-click the viewport > **Parallel** (orthographic) projection for a clean engineering look.
3. If using perspective, set the focal length to ~50mm to avoid distortion.

### Materials and Appearance

1. Open **Appearances** (right-click the component in the browser > **Appearance**).
2. Apply the following:
   - **Crankshaft:** Steel - Polished or Steel - Satin.
   - **Pistons:** Aluminum - Polished.
   - **Connecting Rods:** Steel - Dark or Forged Steel.
   - **Wrist Pins:** Chrome or Bearing Steel.
3. Ensure no component has the default blue/grey material.

### Background

1. In the Animation workspace, click **Storyboard** panel.
2. Right-click the first shot > **Camera Settings**.
3. Set background to **Solid Color** > White (#FFFFFF) or Light Gray (#F0F0F0).
4. Disable shadows if they create visual clutter.

### Export

1. Click **Export** (Animation workspace toolbar).
2. Settings:
   - **Format:** MP4 (H.264).
   - **Resolution:** 1920x1080.
   - **Frame Rate:** 30 fps.
3. Save to `assets/animations/crankshaft_rotation.mp4`.
4. Run `bash scripts/process_assets.sh` to convert to `assets/animations/turntable.gif`.

---

## B. Exploded View (Static PNG)

**Purpose:** Static image showing every component separated, used in the README demo table.

### Fusion 360 Steps

1. Return to the **Design** workspace.
2. Go to **Assemble** > **Explode**.
3. Select all components (Ctrl+A in the canvas or select the root node).
4. Drag components outward along logical assembly axes:
   - **Pistons:** Move upward (Y-axis) away from the cylinders.
   - **Connecting Rods:** Move upward, midway between pistons and crankshaft.
   - **Wrist Pins:** Move upward, between pistons and connecting rods.
   - **Crankshaft:** Leave in place as the reference.
5. Adjust distances so no components overlap from the camera angle.
6. Click **OK** to finalize the explosion state.

### Camera Setup

1. Match the isometric angle from the turntable (30-degree elevation, crankshaft left-to-right).
2. Ensure all 13 components are visible and separated.
3. Frame the view so there is equal whitespace on all sides.

### Annotation (Optional but Recommended)

1. Switch to **Drawing** workspace or use the **Annotate** toolbar in Design.
2. Add part number callouts or balloons next to each component.
3. If balloons clutter the view, skip annotations and rely on the BOM table in the README.

### Export

1. From the Design workspace, go to **File** > **Export**.
2. Or use the **Image** capture button (camera icon in the toolbar).
3. Settings:
   - **Format:** PNG.
   - **Resolution:** 1920x1080 or higher (2560x1440 preferred).
   - **Background:** White or Light Gray (match the turntable).
4. Save to `assets/images/assembly_exploded.png`.

---

## C. Exploded View Animation (GIF)

**Purpose:** Animated sequence showing assembly/disassembly for the README or portfolio site.

### Fusion 360 Steps

1. Start from the exploded state created in Section B.
2. Switch to the **Animation** workspace.
3. Click **Transform Components** on the toolbar.
4. If the explosion was created in the Design workspace, Fusion may auto-generate an animation timeline. If not:
   - Set the timeline to 0 seconds.
   - Click **Record** or manually keyframe each component's position.
5. Build the sequence on the timeline:
   - **0s - 3s:** Components explode outward (same directions as the static view).
   - **3s - 4s:** Hold at full explosion (pause for comprehension).
   - **4s - 7s:** Components collapse back to assembled positions.
6. Adjust easing: right-click keyframes > **Ease In/Out** for smooth motion.

### Timing Reference

| Time | State |
|------|-------|
| 0.0s | Fully assembled |
| 3.0s | Fully exploded |
| 4.0s | Still fully exploded (pause) |
| 7.0s | Fully assembled again |

### Export

1. Click **Export** in the Animation workspace.
2. Settings:
   - **Format:** MP4 (H.264).
   - **Resolution:** 1920x1080.
   - **Frame Rate:** 30 fps.
3. Save to `assets/animations/explode_collapse.mp4`.
4. Convert to GIF:
   ```bash
   ffmpeg -i assets/animations/explode_collapse.mp4 \
     -vf "fps=15,scale=600:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
     -loop 0 assets/animations/explode_collapse.gif
   ```

---

## D. Section View (Cutaway)

**Purpose:** Cross-section showing internal geometry (pin bores, journal clearances, wall thickness).

### Fusion 360 Steps

1. Open the full assembly in the **Design** workspace.
2. Go to **Inspect** > **Section Analysis**.
3. In the Section Analysis dialog:
   - **Plane:** Select the XZ plane (or the plane that cuts through the crankshaft axis).
   - **Offset:** Adjust to cut through one cylinder, showing:
     - Piston interior (ring grooves, pin bore).
     - Connecting rod cross-section (I-beam profile).
     - Crankshaft journal and crankpin.
   - **Flip:** Toggle if the wrong half is displayed.
4. Check **Hatch** to show cross-hatched section cuts.
5. Click **OK**.

### Camera Setup

1. Orient to a front or side view so the cutting plane is perpendicular to the camera.
2. The crankshaft axis should be horizontal.
3. Frame the view to show one complete cylinder assembly in cross-section.

### What to Show

- Piston wall thickness and ring groove depths.
- Wrist pin bore and its clearance with the connecting rod small end.
- Connecting rod I-beam cross-section (web and flanges).
- Crankshaft main journal and crankpin diameters.
- Fillet radii at journal-to-web transitions.

### Export

1. Use **File** > **Export** or the **Image** capture button.
2. Settings:
   - **Format:** PNG.
   - **Resolution:** 1920x1080.
   - **Background:** White.
3. Save to `assets/images/section_view.png`.

---

## E. Component Detail Shots

**Purpose:** Close-up images of individual components for the README or portfolio gallery.

### Crankshaft Close-Up

1. Hide all components except the crankshaft (right-click > **Isolate**).
2. Orbit to show:
   - Main journal surfaces (the smooth cylindrical surfaces that sit in bearings).
   - Crankpin surfaces (the offset journals that connect to the rods).
   - Fillet radii at the transitions between journals and webs.
   - Keyway or woodruff key slot on the flange end (if modeled).
3. Camera: isometric or 3/4 view, fill the frame with the crankshaft.
4. Export to `assets/images/crankshaft_detail.png`.

### Connecting Rod Close-Up

1. Isolate one connecting rod.
2. Show two angles:
   - **Front view:** I-beam cross-section visible, big end and small end in frame.
   - **Angled view:** Big end bore visible, showing the bearing surface.
3. Camera: fill the frame, neutral background.
4. Export to `assets/images/connecting_rod_detail.png`.

### Piston Close-Up

1. Isolate one piston.
2. Orbit to show:
   - Ring grooves (three grooves for compression and oil control rings).
   - Pin bore (the hole for the wrist pin).
   - Crown surface (top of the piston).
   - Skirt (lower cylindrical surface).
3. Camera: 3/4 view showing the crown and side profile.
4. Export to `assets/images/piston_detail.png`.

### Wrist Pin Close-Up

1. Isolate one wrist pin.
2. Show:
   - Full cylindrical surface (polished finish).
   - Chamfered edges.
   - Any retaining ring grooves (if modeled).
3. Camera: side view or slight angle to show the cylindrical form.
4. Export to `assets/images/wrist_pin_detail.png`.

---

## F. 2D Engineering Drawing (Crankshaft)

**Purpose:** Dimensioned drawing with GD&T callouts. This is the core technical deliverable.

### Fusion 360 Steps

1. Open the crankshaft component (or the full assembly with crankshaft as the active component).
2. Go to **Design** > **Document** > **New Drawing** > **From Design**.
3. In the Create Drawing dialog:
   - **Template:** ISO or ANSI (match your GD&T standard; ASME uses ANSI).
   - **Standard:** ASME.
   - **Units:** Millimeters.
   - **Sheet Size:** A3 or A2 (need room for multiple views and a title block).
4. Click **OK** to enter the Drawing workspace.

### View Placement

Place the following views on the sheet:

| View | Position | Purpose |
|------|----------|---------|
| Front | Top-left | Main profile showing crank throws, journals, overall length |
| Side | Top-right | End view showing journal diameters, flange bolt pattern |
| Top | Bottom-left | Plan view showing web thickness, counterweight profiles |
| Isometric | Bottom-right | 3D reference for non-technical readers |
| Detail A | Lower-right area | Enlarged view of one fillet radius at journal-to-web transition |

### Dimensioning

Add the following dimensions:

**Overall:**
- Total length of the crankshaft.
- Distance between main bearing journals (bearing span).

**Main Journals:**
- Diameter of each main journal (with tolerance, e.g., 50.000 +/- 0.013 mm).
- Length of each journal.

**Crankpins:**
- Diameter of each crankpin.
- Stroke (distance from main journal axis to crankpin axis, doubled = piston stroke).

**Fillet Radii:**
- Radius at each journal-to-web transition (critical for fatigue life).

**Flange:**
- Flange diameter.
- Bolt circle diameter.
- Number and diameter of bolt holes.
- Keyway dimensions (width, depth, length).

### GD&T Callouts

Apply the following GD&T frame annotations per ASME Y14.5:

**Datum Establishments:**

| Datum | Feature | Description |
|-------|---------|-------------|
| A | Main journal axis | Primary datum (centerline of the main bearing bore) |
| B | Flange face | Secondary datum (axial location reference) |
| C | Keyway center plane | Tertiary datum (clocking/orientation reference) |

**Tolerance Callouts:**

| Feature | Tolerance | Value | Datum(s) | Symbol |
|---------|-----------|-------|----------|--------|
| Main journal OD | Cylindricity | 0.010 mm | A | ( cylindricity symbol ) |
| Main journal OD | Diameter | 50.000 +/- 0.013 mm | A | Linear dim |
| Crankpin OD | Cylindricity | 0.012 mm | A | ( cylindricity symbol ) |
| Crankpin position | Position | 0.025 mm | A, B | ( position symbol ) |
| Flange face | Flatness | 0.015 mm | B | ( flatness symbol ) |
| Flange face | Perpendicularity | 0.020 mm | A | ( perpendicularity symbol ) |
| Overall runout | Circular runout | 0.030 mm | A, B | ( runout symbol ) |
| Keyway width | Position | 0.050 mm | A, B, C | ( position symbol ) |

### Export

1. Click **Finish Drawing**.
2. Go to **File** > **Export** or **Print** > **Save as PDF**.
3. Settings:
   - **Format:** PDF.
   - **Resolution:** High quality.
4. Save to `drawings/crankshaft_drawing.pdf`.

---

## G. Bill of Materials

**Purpose:** Structured parts list for the README and manufacturing reference.

### Fusion 360 Steps

1. Open the full assembly.
2. Go to **Design** > **Inspect** > **Bill of Materials**.
3. In the BOM dialog:
   - Ensure all 13 components are listed.
   - Verify quantities match expected counts.
4. Review the columns. Add or verify these fields:

| Column | Source | Notes |
|--------|--------|-------|
| Part Name | Auto-generated | Rename if generic (e.g., "Body1" -> "Piston") |
| Material | Component property | Set in Design > Physical Material |
| Quantity | Auto-calculated | Should be: 1 crankshaft, 4 pistons, 4 rods, 4 pins |
| Mass | Computed from material + volume | Verify against expected values |

### Export

**Option A: Screenshot**
1. Position the BOM dialog so all rows and columns are visible.
2. Take a screenshot and save to `assets/images/bom_table.png`.

**Option B: CSV Export**
1. In the BOM dialog, look for an **Export** or **Save As** option.
2. Export as CSV to `drawings/bom.csv`.

### Expected BOM Data

| # | Part Name | Material | Qty | Mass (approx) |
|---|-----------|----------|-----|---------------|
| 1 | Crankshaft | AISI 4340 Steel | 1 | ~4.5 kg |
| 2 | Piston | A390 Aluminum | 4 | ~0.3 kg each |
| 3 | Connecting Rod | 4340 Steel (Forged) | 4 | ~0.6 kg each |
| 4 | Wrist Pin | 52100 Bearing Steel | 4 | ~0.05 kg each |

---

## H. Checklist Before Recording

Use this checklist before starting any capture session:

- [ ] Assembly is fully constrained (no components floating or misaligned).
- [ ] All components have correct materials assigned (no default blue).
- [ ] Component names are clean in the browser tree (no "Body1", "Component2", etc.).
- [ ] Viewport background is set to white or light gray.
- [ ] Visual style is set to **Shaded with Visible Edges** for technical shots.
- [ ] No construction geometry visible (hide sketches, planes, axes).
- [ ] Origin is hidden.
- [ ] Screenshot test: capture a single frame to verify resolution and framing.
- [ ] Export paths match the repo structure (`assets/animations/`, `assets/images/`, `drawings/`).
