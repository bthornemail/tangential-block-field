---
omino-centroid: "0x00"
omino-azimuth: "0°"
geometric-stratum: "±3: USER"
formal-theory: "Tangential Block Field"
computational-architecture: "Tangential Blackboard"
shared-projection-surface: "Blackboard Field"
substrate-targets:
  declarations: "./.omi/rules.omi"
  definitions: "./.omi/rules.imo"
  binary: "./.omi/rules.o"
---
# Blackboard Field — The Surface of Visibility

The Blackboard Field is not a globally materialized database or a database object [0x01.1]. It is a bounded projective field ($\mathbb{B} = (P_B, S, \Gamma)$) in which independent relational blocks become jointly visible [0x01.1, 0x01.3].

The 256-position computational field is partitioned into an eight-bit plane view, where bit 7 acts as the local/remote selector ($0\text{x}00\dots0\text{x}7\text{F}$ local, $0\text{x}80\dots0\text{x}\text{FF}$ remote) [0x01.11, 0x01.12]. This byte plane is related through an involutive antipodal projection ($a(x) = x \oplus 0\text{x}80$), preserving a single centroid with opposing orientations [0x01.12].
