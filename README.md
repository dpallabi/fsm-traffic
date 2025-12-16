🚦 FSM-Based Traffic Light Controllers using Verilog HDL
Urban Intersection & Highway–Country Road Scenarios
📌 Overview

This repository presents a comprehensive FSM-based traffic light control system implemented in Verilog HDL, covering two real-world traffic scenarios:

Urban Intersection Traffic Controller

Highway–Country Road Traffic Controller

The designs model realistic traffic behavior by incorporating pedestrian safety, emergency vehicle priority, adaptive signal timing, time-dependent operation, and parking slot management.
All modules are fully synthesizable and verified using Icarus Verilog and GTKWave.

This repository demonstrates progressive system design, starting from structured FSM-based traffic control and extending to intelligent transportation system (ITS) concepts.

🧩 Project Structure
├── urban_traffic/
│   ├── trafficv4.v          # Urban FSM-based traffic controller
│   ├── tb_trafficv4.v       # Testbench
│   └── urban_waveform.png
│
├── highway_traffic/
│   ├── trafficv2.v          # Highway–Country FSM controller
│   ├── tb_trafficv2.v       # Testbench
│   └── highway_waveform.png
│
└── README.md

🏙️ Module 1: Urban Traffic Light Controller
🔹 Description

An adaptive smart urban traffic controller implemented as a Moore FSM, designed to model real-world city intersections.
The controller dynamically responds to traffic conditions, pedestrian demands, emergency vehicles, and time-of-day variations.

✨ Key Features

Vehicle Traffic Handling

Standard GREEN → YELLOW → RED sequencing

Vehicle presence detection via sensors

Pedestrian Crossing Phase

Dedicated pedestrian state

Ensures complete traffic halt during crossing

Emergency Vehicle Override

Immediate signal preemption

Forces GREEN signal for emergency clearance

Adaptive Green Timing

Adjusts green duration based on traffic density

Supports low-traffic and normal-traffic modes

Early-Morning Flashing Yellow Mode

Blinking yellow operation during low traffic hours

Models real-world early-morning intersections

Parking Slot Management

Independent counter-based subsystem

Tracks vehicle entry and exit in parking areas

🔁 FSM States (Urban)
State	Description
IDLE	Default waiting state
GREEN	Vehicle green signal
YELLOW	Vehicle yellow signal
RED	Vehicle red signal
PEDESTRIAN	Pedestrian crossing phase
EMERGENCY	Emergency override
YELLOW_BLINK	Flashing yellow mode
🧪 Simulation & Verification

Verified through a comprehensive testbench covering:

Normal traffic flow

Pedestrian requests

Emergency events

Adaptive timing transitions

Parking slot updates

Waveform inspection confirms correct FSM transitions and signal behavior.

🛣️ Module 2: Highway–Country Road Traffic Controller
🔹 Description

A FSM-based traffic controller designed for a highway–country road intersection, prioritizing highway traffic while safely handling low-volume country road vehicles.
The system supports time-dependent operation, distinguishing between day mode and night mode.

✨ Key Features

FSM-based synchronous traffic control

Separate signal handling for highway and country road

Day and Night operating modes

Sensor-driven and event-driven transitions

Modular and extensible design

🕒 Operating Modes
🔆 Day Mode (05:00 – 09:00)

Controlled using vehicle sensor input (X)

Highway remains GREEN if no country-road traffic

Full transition sequence executed when vehicle detected

🌙 Night Mode (Outside 05:00 – 09:00)

Controlled using a character detector

Traffic switches based on valid character input

Demonstrates event-driven FSM behavior

🔁 FSM States (Highway)
State	Description
s0	Highway Green, Country Red
s1	Highway Green (delay)
s2	Highway Yellow
s3	Country Green
s4	Country Yellow
s5	Reserved
🚥 Traffic Light Encoding
Value	Meaning
11	Green
01	Yellow
00	Red
🛠 Tools & Technologies

Hardware Description Language: Verilog HDL

Design Methodology: FSM-based synchronous design

Simulation: Icarus Verilog (iverilog, vvp)

Waveform Analysis: GTKWave

▶️ How to Run (Example)
Compile
iverilog -o traffic.out traffic.v tb_traffic.v

Run Simulation
vvp traffic.out

View Waveforms
gtkwave traffic.vcd

📌 Key Learning Outcomes

Practical FSM design for real-world traffic systems

Handling asynchronous events in synchronous designs

Adaptive timing and multi-mode control logic

Integration-ready design for intelligent transportation systems

Strong foundation for smart city, VLSI, and embedded systems applications

🚀 Future Extensions

Integration with AI-based traffic decision layers

Sensor fusion using real-time data

Multi-intersection coordination

Hardware deployment on FPGA platforms
