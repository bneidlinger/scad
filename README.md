# ░█▀█░░█▀▄░░░░█▀█░█▀▄░▀█▀░█▀█░▀█▀░█▀▀
# ░░▀▄░░█░█░░░░█▀▀░█▀▄░░█░░█░█░░█░░▀▀█
# ░▀▀░░░▀▀░░░░░▀░░░▀░▀░▀▀▀░▀░▀░░▀░░▀▀▀

> **Parametric 3D Designs | Functional Architecture | OpenSCAD**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-00ffff.svg)](https://creativecommons.org/licenses/by/4.0/)
[![OpenSCAD](https://img.shields.io/badge/OpenSCAD-Parametric-ff00ff.svg)](https://openscad.org/)
[![3D Printing](https://img.shields.io/badge/3D%20Printing-Ready-ffff00.svg)](#print-settings)

```
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██ ╔═══════════════════════════════════════════════════════════════════════╗ ██
██ ║                    FUNCTIONAL PARAMETRIC DESIGN                      ║ ██
██ ║                        Code → Blueprint → Object                     ║ ██
██ ╚═══════════════════════════════════════════════════════════════════════╝ ██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
```

## 🎯 **Projects**

### 📺 **Echo Show 5 Mount** → `show5/`
**Under-cabinet mount with precision friction hinge**
- ⚡ **Parametric device cradle** with adjustable clearances
- 🔩 **Micro-detent hinge** for positioning feedback  
- 🚫 **Support-free printing** optimized for 0.6mm nozzle
- 📐 **Real-world fasteners** (M3 hardware, #8 wood screws)

```openscad
// Tune for your device
device_w = 148;    // Echo Show 5 width
clear = 1.0;       // fit clearance (increase if tight)
detent_teeth = 12; // hinge positioning (0 = smooth)
```

### 🏛️ **Art-Deco Sconce** → `skyscrapersconce/`
**Architectural light fixture shroud for E26 sockets**
- 🔥 **Heat-conscious design** for LED bulbs only
- ⚡ **Code-compliant mounting** to standard junction boxes
- 🏗️ **Stepped deco styling** with parametric proportions
- 💨 **Integrated ventilation** slots and thermal management

```openscad
// Architectural parameters  
spire_steps = 5;        // number of deco steps
box_slot_center = 89;   // standard 3.5" screw spacing
socket_clear_d = 52;    // E26 ceramic socket clearance
```

---

## 🔧 **Design Philosophy**

### **Parametric Thinking**
Every dimension is a **variable**, not a measurement. Change one parameter and watch the entire design update intelligently—like architectural blueprints that adapt to site conditions.

### **Print-Conscious Engineering**  
- 🎯 **0.6mm nozzle optimized** for strength and speed
- 🚫 **Support-free geometry** with 45° overhang limits  
- ⚙️ **Mechanical clearances** built into the code
- 🏭 **Material specifications** (PETG indoor, ASA outdoor)

### **Real-World Integration**
- 📏 **Hardware-driven dimensions** (actual screw sizes, device measurements)
- ⚡ **Safety-first electrical** (LED-only, proper ventilation, code compliance)
- 🔧 **Assembly instructions** embedded in design documentation
- 🧪 **Test-print protocols** for critical tolerances

---

## ⚡ **Quick Start**

### **Prerequisites**
```bash
# Install OpenSCAD
# Download from: https://openscad.org
# Windows/Mac/Linux supported
```

### **Workflow**
```bash
# 1. Clone repository
git clone https://github.com/bneidlinger/3dprints.git

# 2. Open .scad files in OpenSCAD
# 3. Modify parameters at top of file
# 4. Preview: F5 | Render: F6
# 5. Export STL for 3D printing
```

### **Customization**
Each project has **tuning parameters** at the top:
- `clear` → fit adjustments  
- `*_teeth` → mechanical features
- `*_clearance` → hardware tolerances
- `material_thickness` → structural elements

---

## 🎨 **Print Settings**

### **Recommended Hardware**
- **Printer**: Bambu A1 or equivalent (220mm² minimum build volume)
- **Nozzle**: **0.6mm** (optimized line widths)  
- **Materials**: **PETG** (indoor), **ASA** (heat/outdoor)

### **Slice Settings**
```yaml
Layer Height: 0.28mm      # 0.6mm nozzle optimized
Walls: 4 perimeters       # structural strength  
Infill: 25% gyroid        # weight/strength balance
Top/Bottom: 4 layers      # clean surfaces
Supports: NONE            # designs are support-free
```

### **Orientation**
- **Plates/sleds**: Flat on build surface
- **Spires/shrouds**: Opening face up (natural print orientation)
- **Small parts**: Minimize support material

---

## ⚠️ **Safety & Compliance**

### **Electrical Projects**
- 🔥 **LED bulbs only** — never incandescent (heat management)
- ⚡ **Junction box mounting** required (no exposed wiring)
- 🏗️ **Code compliance** — consult local electrical codes
- 🧪 **Thermal testing** — 30-minute runtime validation

### **Mechanical Projects**  
- 🔩 **Proper fasteners** — use specified hardware grades
- 📐 **Load considerations** — designs have weight limits
- 🔧 **Assembly sequence** — follow documented procedures

---

## 📚 **Learning Resources**

### **Interactive Guide**
🌐 **[OpenSCAD Learning Guide](https://bneidlinger.github.io/scad/)**  
*Comprehensive tutorial with retro-architect styling*

### **In This Repository**
- 📖 **Detailed READMEs** for each project
- 💾 **Fully commented .scad** source code  
- 📐 **Parameter explanations** and tuning guides
- 🏗️ **Assembly instructions** with hardware specs

### **OpenSCAD Resources**
- 🌐 [Official Documentation](https://openscad.org/documentation.html)
- 💬 [Community Forum](https://forum.openscad.org/)
- 📖 [Cheat Sheet](https://openscad.org/cheatsheet/)

---

## 🎯 **Project Structure**

```
📁 3dprints/
├── 📄 README.md                    # This file
├── 📄 CLAUDE.md                    # AI assistant guidance
├── 📄 index.html                   # Learning guide (web)
├── 📁 show5/
│   ├── 📄 echo_show5_gen1_mount.scad
│   └── 📄 echo_show5_gen1_mount_README.md
└── 📁 skyscrapersconce/
    ├── 📄 deco_beacon_sconce.scad
    └── 📄 deco_beacon_README.md
```

---

## 🤝 **Contributing**

### **Design Principles**
- ✅ **Parametric first** — every dimension should be adjustable
- ✅ **Support-free** — design for additive manufacturing constraints  
- ✅ **Safety conscious** — especially for electrical/mechanical projects
- ✅ **Documentation** — comment your code like architectural drawings

### **Submission Guidelines**
1. **Fork** repository
2. **Create feature branch** (`feature/new-mount-design`)
3. **Test print** critical dimensions
4. **Document thoroughly** (README + code comments)
5. **Submit pull request** with photos of printed results

---

## 📜 **License & Attribution**

### **Creative Commons BY 4.0**
```
You are free to:
  ✅ Share — copy and redistribute in any medium or format
  ✅ Adapt — remix, transform, and build upon the material
  ✅ Commercial use — for any purpose, even commercially

Under these terms:
  📝 Attribution — You must give appropriate credit
  🔗 Link to license — Indicate if changes were made
  🚫 No additional restrictions — Don't add legal/technical restrictions
```

### **Attribution Format**
```
Original design by bneidlinger
https://github.com/bneidlinger/3dprints
Licensed under CC BY 4.0
```

---

## 📡 **Connect**

- 🌐 **Website**: [bneidlinger.github.io](https://bneidlinger.github.io)
- 📚 **OpenSCAD Guide**: [bneidlinger.github.io/scad](https://bneidlinger.github.io/scad/)
- 💾 **Repository**: [github.com/bneidlinger/3dprints](https://github.com/bneidlinger/3dprints)

```
▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄
██                                                                          ██
██  "The best designs are those that solve real problems with elegance,     ██  
██   then make themselves infinitely adaptable through parameterization."   ██
██                                                          — bneidlinger   ██
██                                                                          ██
▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
```