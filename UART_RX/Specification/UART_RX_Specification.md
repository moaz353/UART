# UART Receiver (UART_RX)
## Design Specification

## 1. Introduction

### 1.1 Purpose

This document specifies the functional behavior, interface, and timing requirements of a Universal Asynchronous Receiver/Transmitter Receiver (UART_RX). The UART_RX reconstructs parallel data from a serial bitstream received over a UART serial link.

### 1.2 Scope

The specification covers:

- Top-level interface and signal descriptions
- Frame format definitions for all parity configurations
- Reception sequencing, start-bit verification, and error-detection behavior
- Oversampling and sampling-timing requirements
- Timing requirements and reset behavior

## 2. Design Overview

### 2.1 Functional Summary

The UART_RX is a synchronous, single-clock-domain module that:

1. Monitors the serial input line while idle and detects a low level as a possible start condition.
2. Verifies the start candidate by oversampling; rejects line glitches that are not genuine start bits.
3. Samples the 8 data bits (LSB first) using 8x oversampling with triple-sample majority voting.
4. Computes the expected parity bit on the received data (even or odd, configurable).
5. Compares the calculated parity with the received parity bit and flags a parity error on mismatch.
6. Verifies the stop bit and flags a framing error when it is not logic 1.
7. Drives the reconstructed frame on the parallel output together with a data-valid status signal.
8. Discards the frame entirely when any error is detected, never presenting corrupted data.

## 3. Design Interface

### 3.1 Port List

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `CLK` | Input | 1 | System clock. All sequential behavior is referenced to the rising edge of this signal. |
| `RST_n` | Input | 1 | Asynchronous active-low reset. When asserted (low), the module is placed in its initial state. |
| `RX_IN` | Input | 1 | Serial receive data input. A low level on this line while the receiver is idle indicates a possible start condition. |
| `PAR_EN` | Input | 1 | Parity enable configuration. When low, parity is disabled. When high, parity is enabled. |
| `PAR_TYP` | Input | 1 | Parity type configuration. When low, even parity is selected. When high, odd parity is selected. Meaningful only when `PAR_EN` is high. |
| `P_DATA` | Output | 11 | Reconstructed frame: `{start bit, 8 data bits, parity field, stop bit}`. When `PAR_EN = 0`, the parity field is unused and forced to logic 1. Valid only when `DATA_VALID` is asserted. |
| `DATA_VALID` | Output | 1 | Status signal. High for 8 clock cycles when `P_DATA` holds a verified frame. |

---

## 4. Configuration Signals

### 4.1 Parity Enable (`PAR_EN`)

| Value | Behavior |
|-------|----------|
| `0` | Parity bit is **not** expected or checked in the received frame. 10-bit frame. |
| `1` | Parity bit **is** expected and checked in the received frame. 11-bit frame. |

### 4.2 Parity Type (`PAR_TYP`)

| Value | Behavior |
|-------|----------|
| `0` | Even parity: the calculated parity bit makes the total number of logic-1 bits across data and parity even. A mismatch between calculated and received parity is flagged as a parity error. |
| `1` | Odd parity: the calculated parity bit makes the total number of logic-1 bits across data and parity odd. A mismatch between calculated and received parity is flagged as a parity error. |

### 4.3 P_DATA Parity Field When Parity Is Disabled

`P_DATA` is always 11 bits wide, regardless of the parity configuration. When `PAR_EN = 0`, the parity field position does not represent a received bit:

- The parity field is **unused** when `PAR_EN = 0`.
- The reserved parity position is **forced to logic 1** in this configuration.
- This forced value is not a received parity bit and carries no information.

---

## 5. Functional Specifications

### 5.1 Oversampling

The serial input shall be sampled **8 times per bit period**. An internal edge counter counts the 8 oversampling edges (0-7) within each bit window, and a bit counter tracks the bit position within the frame.

### 5.2 Majority Voting

`RX_IN` shall be captured at edge counts **3, 4, and 5** of each bit window. The three samples shall be resolved by a **2-of-3 majority vote** into a single `SAMPLED_BIT`. This suppresses noise on the serial line: at least two of the three middle samples must agree.

### 5.3 Start Bit Detection

The receiver shall monitor `RX_IN` while in the `IDLE` state. A low level detected on `RX_IN` shall be treated as a possible start condition, and the receiver shall then enter start-bit verification. The start candidate shall be sampled for a full bit window.

### 5.4 Start Bit Verification (Glitch Rejection)

The majority-sampled value of the start candidate shall be checked:

- If the majority-sampled value is **logic 0**, the start bit is genuine and data reception proceeds.
- If the majority-sampled value is **logic 1**, the low pulse is classified as a line glitch. The receiver shall flag a glitch and return to idle without processing a frame.

> **Note:** `STR_GLITCH`, `PAR_ERR`, and `STP_ERR` are internal error indicators used by the receiver controller. They are not exposed as output ports at the UART_RX top-level interface; their effect is observed externally through the absence of `P_DATA`/`DATA_VALID` output.

### 5.5 Data Reception Order

Data bits shall be received **LSB first**. Bit 0 of the frame shall be sampled first, followed by bit 1 through bit 7. Each received data bit shall be stored in the receiver data register and shall contribute to the parity calculation.
### 5.6 Parity Check

When `PAR_EN = 1`, the calculated parity bit shall be compared with the received parity bit:

- On match, reception proceeds to the stop-bit check.
- On mismatch, a parity error shall be flagged and the receiver shall discard the frame by returning to idle. `P_DATA` shall not be presented and `DATA_VALID` shall not be asserted.

### 5.7 Stop Bit Check

The majority-sampled stop bit shall be verified:

- If the stop bit is **logic 1**, the frame is valid and reception proceeds to the output phase.
- If the stop bit is **logic 0**, a framing error shall be flagged and the receiver shall discard the frame by returning to idle.

### 5.8 Data Output

`DATA_VALID` shall be asserted only after the following checks have all completed successfully:

- Successful start-bit verification
- Successful data reception
- Successful parity check (if parity is enabled)
- Successful stop-bit verification

A frame in which any error is detected shall never assert `DATA_VALID`.

Upon a verified frame, the receiver shall assert `DATA_VALID` high for **8 clock cycles**. `P_DATA` shall hold the reconstructed frame during this window:

With parity enabled:
P_DATA contains start bit, received data byte, received parity bit, and stop bit.

With parity disabled:
P_DATA contains start bit, received data byte, a reserved parity field forced to logic 1, and stop bit.

### 5.9 Frame Rejection on Error

Any detected error (start-bit glitch, parity error, or stop-bit/framing error) shall cause the receiver to return to idle immediately. A rejected frame shall never drive `P_DATA` or assert `DATA_VALID`; these outputs are reserved for verified frames only.

## 6. Frame Format

The UART_RX supports 8-bit data frames consisting of one start bit, eight data bits, an optional parity bit, and one stop bit.

### 6.1 Supported Frame Formats

The UART_RX supports **8-bit data reception with one start bit, an optional parity bit, and one stop bit**. Three frame formats are supported depending on the parity configuration. Each bit occupies **8 clock cycles**.

#### 6.1.1 Frame with Even Parity (`PAR_EN=1`, `PAR_TYP=0`)

| Field | Bit Value | Duration |
|-------|-----------|----------|
| Start bit | Logic 0 (verified) | 8 clock cycles |
| Data bit 0 (LSB) | Received data | 8 clock cycles |
| Data bit 1 | Received data | 8 clock cycles |
| Data bit 2 | Received data | 8 clock cycles |
| Data bit 3 | Received data | 8 clock cycles |
| Data bit 4 | Received data | 8 clock cycles |
| Data bit 5 | Received data | 8 clock cycles |
| Data bit 6 | Received data | 8 clock cycles |
| Data bit 7 (MSB) | Received data | 8 clock cycles |
| Even parity bit | Checked against calculation | 8 clock cycles |
| Stop bit | Logic 1 (verified) | 8 clock cycles |

**Total frame length: 11 bits (88 clock cycles)**

#### 6.1.2 Frame with Odd Parity (`PAR_EN=1`, `PAR_TYP=1`)

| Field | Bit Value | Duration |
|-------|-----------|----------|
| Start bit | Logic 0 (verified) | 8 clock cycles |
| Data bit 0 (LSB) | Received data | 8 clock cycles |
| Data bit 1 | Received data | 8 clock cycles |
| Data bit 2 | Received data | 8 clock cycles |
| Data bit 3 | Received data | 8 clock cycles |
| Data bit 4 | Received data | 8 clock cycles |
| Data bit 5 | Received data | 8 clock cycles |
| Data bit 6 | Received data | 8 clock cycles |
| Data bit 7 (MSB) | Received data | 8 clock cycles |
| Odd parity bit | Checked against calculation | 8 clock cycles |
| Stop bit | Logic 1 (verified) | 8 clock cycles |

**Total frame length: 11 bits (88 clock cycles)**

#### 6.1.3 Frame without Parity (`PAR_EN=0`)

| Field | Bit Value | Duration |
|-------|-----------|----------|
| Start bit | Logic 0 (verified) | 8 clock cycles |
| Data bit 0 (LSB) | Received data | 8 clock cycles |
| Data bit 1 | Received data | 8 clock cycles |
| Data bit 2 | Received data | 8 clock cycles |
| Data bit 3 | Received data | 8 clock cycles |
| Data bit 4 | Received data | 8 clock cycles |
| Data bit 5 | Received data | 8 clock cycles |
| Data bit 6 | Received data | 8 clock cycles |
| Data bit 7 (MSB) | Received data | 8 clock cycles |
| Stop bit | Logic 1 (verified) | 8 clock cycles |

**Total frame length: 10 bits (80 clock cycles)**

### 6.2 Parity Bit Calculation

The receiver shall calculate the expected parity value from the received 8-bit data according to the selected parity mode.

**Even Parity (`PAR_TYP = 0`):**

The total number of logic-1 bits across the received data and the parity bit shall be **even**.

**Odd Parity (`PAR_TYP = 1`):**

The total number of logic-1 bits across the received data and the parity bit shall be **odd**.

If the received parity bit does not satisfy the selected parity requirement, a parity error shall be flagged and the frame shall be discarded.

## 7. Reset Behavior

When `RST_n` is asserted (driven low), the module shall immediately:

- Return the receiver FSM to the `IDLE` state.
- Clear all counters.
- Clear `DATA_VALID` and all internal error/status flags.
- Place all outputs and internal status signals in a known reset state.
- Prepare the receiver to detect a new start bit.
