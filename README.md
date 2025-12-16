# 🚦 FSM-Based Traffic Light Controllers using Verilog HDL

---

## 📌 Overview

This repository contains **two Finite State Machine (FSM)–based traffic light controller designs** implemented in **Verilog HDL**, targeting real-world traffic scenarios:

- **Highway–Country Road Traffic Light Controller**
- **Urban Intersection Traffic Light Controller**

Both designs are **fully synthesizable**, clock-driven, and verified using **Icarus Verilog** and **GTKWave**.  
The projects emphasize **practical traffic behavior modeling**, safety, and adaptability, making them suitable for **Intelligent Transportation Systems (ITS)** and digital design coursework.

---

## Tools & Technologies

- **Hardware Description Language:** Verilog HDL  
- **Simulation:** Icarus Verilog (`iverilog`, `vvp`)  
- **Waveform Visualization:** GTKWave  
- **Design Methodology:** FSM-based synchronous design  

---

# Highway–Country Road Traffic Light Controller

---

## Description

This controller manages a **highway–country road intersection**, prioritizing highway traffic while safely handling transitions.  
It supports **time-based operation**, switching behavior between **day mode** and **night mode**.

---

## Operating Modes

### Day Mode (05:00 – 09:00)

- Controlled using vehicle sensor input
- Highway remains GREEN unless country-road traffic is detected
- Full transition sequence executed when required

### Night Mode (Outside 05:00 – 09:00)

- Controlled using a character detector
- Traffic switches only on valid external input
- Reduces unnecessary signal changes during low traffic

---

## FSM States

- `s0` – Highway Green, Country Red  
- `s1` – Highway Green (delay)  
- `s2` – Highway Yellow  
- `s3` – Country Green, Highway Red  
- `s4` – Country Yellow  

---

## Traffic Light Encoding

- `11` → Green  
- `01` → Yellow  
- `00` → Red  

---

## Important Signals

- `clock` – System clock  
- `clear` – FSM reset  
- `X` – Vehicle sensor (day mode)  
- `char[7:0]` – Character input (night mode)  
- `state[2:0]` – Current FSM state  
- `next_state[2:0]` – Next FSM state  
- `hwy[1:0]` – Highway traffic light  
- `country[1:0]` – Country road traffic light  

---

## Simulation & Verification

The design is verified using:

- **Icarus Verilog** for compilation and simulation  
- **GTKWave** for waveform visualization  

---

## How to Run (Highway Controller)

```sh
iverilog -o trafficv2.out trafficv2.v tb_trafficv2.v
vvp trafficv2.out
gtkwave trafficv2.vcd
```

---
# Urban Traffic Light Controller

---

## Description

The **Urban Traffic Light Controller** models a smart city intersection with adaptive behavior.  
It extends a basic traffic FSM by incorporating **pedestrian safety, emergency vehicle priority, adaptive green timing, parking slot management, and early-morning flashing modes**.

---

## Key Features

- **Vehicle Traffic Handling**
  - Standard GREEN → YELLOW → RED sequencing
  - Vehicle presence detection

- **Pedestrian Crossing Phase**
  - Dedicated pedestrian FSM state
  - All vehicle traffic halted during crossing

- **Emergency Vehicle Override**
  - Immediate signal preemption
  - Forces GREEN signal for emergency clearance

- **Parking Slot Management**
  - Tracks available parking slots
  - Updates slot count on vehicle entry/exit

- **Adaptive Green Timing**
  - Shorter green duration during low traffic
  - Normal duration during peak traffic
    
---

## FSM States

- `IDLE`
- `GREEN`
- `YELLOW`
- `RED`
- `PEDESTRIAN`
- `EMERGENCY`
- `YELLOW_BLINK`

---

## Simulation & Verification

The design is verified using:

- **Icarus Verilog** for compilation and simulation  
- **GTKWave** for waveform visualization  

---

## How to Run (Urban Controller)

```sh
iverilog -o trafficv4.out trafficv4.v tb_trafficv4.v
vvp trafficv4.out
gtkwave trafficv4.vcd
```

---

## Learning Outcomes

- FSM-based digital system design
- Traffic control logic modeling
- Synchronous timing and state transitions
- Testbench-driven verification
- Real-world ITS behavior representation
