# UART Transmitter (UART_TX)
## Design Specification

## 1. Introduction

### 1.1 Purpose

This document specifies the functional behavior, interface, and timing requirements of a Universal Asynchronous Receiver/Transmitter Transmitter (UART_TX). The UART_TX converts parallel data from a master device into a serial bitstream for transmission over a UART serial link.

### 1.2 Scope

The specification covers:

- Top-level interface and signal descriptions
- Frame format definitions for all parity configurations
- Transmission sequencing and handshaking behavior
- Timing requirements and reset behavior

## 2. Design Overview

### 2.1 Functional Summary

The UART_TX is a synchronous, single-clock-domain module that:

1. Accepts an 8-bit parallel data word and a data-valid handshake signal from a host.
2. Constructs a serial frame consisting of a start bit, 8 data bits (LSB first), an optional parity bit, and a stop bit.
3. Drives the serial output line and a busy status signal.
4. Supports even and odd parity through configuration inputs.
5. This implementation assumes one clock cycle per transmitted bit.


## 3. Design Interface

### 3.1 Port List

| Port | Direction | Width | Description |
|------|-----------|-------|-------------|
| `CLK` | Input | 1 | System clock. All sequential behavior is referenced to the rising edge of this signal. |
| `RST_n` | Input | 1 | Asynchronous active-low reset. When asserted (low), the module is placed in its initial state. |
| `P_DATA` | Input | 8 | Parallel data byte to be transmitted. Valid only when `DATA_VALID` is asserted. |
| `DATA_VALID` | Input | 1 | Handshake signal indicating valid data is present on `P_DATA`. Shall be asserted for exactly one clock cycle per transfer. |
| `PAR_EN` | Input | 1 | Parity enable configuration. When low, parity is disabled. When high, parity is enabled. |
| `PAR_TYP` | Input | 1 | Parity type configuration. When low, even parity is selected. When high, odd parity is selected. Meaningful only when `PAR_EN` is high. |
| `TX_OUT` | Output | 1 | Serial transmit data output. Drives the UART TX line. |
| `BUSY` | Output | 1 | Status signal. High when the module is actively transmitting a frame; low when idle. |

---

## 4. Configuration Signals

### 4.1 Parity Enable (`PAR_EN`)

| Value | Behavior |
|-------|----------|
| `0` | Parity bit is **not** included in the transmitted frame. |
| `1` | Parity bit **is** included in the transmitted frame. |



### 4.2 Parity Type (`PAR_TYP`)

| Value | Behavior |
|-------|----------|
| `0` | Even parity: the parity bit is set to ensure the total number of logic-1 bits across data and parity is even. |
| `1` | Odd parity: the parity bit is set to ensure the total number of logic-1 bits across data and parity is odd. |

---

## 5. Functional Specifications

### 5.1 Data Capture

The UART_TX shall accept the parallel data byte on `P_DATA` only when `DATA_VALID` is asserted. `DATA_VALID` shall be asserted for exactly **one clock cycle** to initiate a transfer. The module shall capture the value of `P_DATA` at the rising edge of `CLK` when `DATA_VALID` is high and the module is idle.

### 5.2 Serialization Order

Data bits shall be transmitted **LSB first**. Bit 0 of `P_DATA` shall appear on the serial output first, followed by bit 1, bit 2, and so on through bit 7.

### 5.3 Serial Output in Idle

When no transmission is in progress (`BUSY = 0`), `TX_OUT` shall remain at logic **high**. This is the UART idle line condition.

### 5.4 Busy Signal Behavior

`BUSY` shall be:

- **High** throughout the entire transmission of a frame, from the first clock cycle of the start bit through the last clock cycle of the stop bit.
- **Low** when the module is idle and not transmitting.

### 5.5 Data Rejection During Transmission

When `BUSY = 1`, the module shall **ignore** any assertion of `DATA_VALID`. The module shall not accept new data, queue data, or buffer data while actively transmitting a frame. The host is responsible for ensuring `DATA_VALID` is only asserted when `BUSY = 0`.

### 5.6 Bit Timing

Each bit in the serial frame shall occupy exactly **one clock cycle**. The baud rate is therefore equal to the clock frequency. No oversampling or fractional baud rate generation is performed by this module.

## 6. Frame Format

### 6.1 Supported Frame Formats

The UART_TX supports three frame formats depending on the parity configuration.

#### 6.1.1 Frame with Even Parity (`PAR_EN=1`, `PAR_TYP=0`)

| Field | Bit Value | Duration |
|-------|-----------|----------|
| Start bit | Logic 0 | 1 clock cycle |
| Data bit 0 (LSB) | `P_DATA[0]` | 1 clock cycle |
| Data bit 1 | `P_DATA[1]` | 1 clock cycle |
| Data bit 2 | `P_DATA[2]` | 1 clock cycle |
| Data bit 3 | `P_DATA[3]` | 1 clock cycle |
| Data bit 4 | `P_DATA[4]` | 1 clock cycle |
| Data bit 5 | `P_DATA[5]` | 1 clock cycle |
| Data bit 6 | `P_DATA[6]` | 1 clock cycle |
| Data bit 7 (MSB) | `P_DATA[7]` | 1 clock cycle |
| Even parity bit | Computed parity | 1 clock cycle |
| Stop bit | Logic 1 | 1 clock cycle |

**Total frame length: 11 clock cycles**

#### 6.1.2 Frame with Odd Parity (`PAR_EN=1`, `PAR_TYP=1`)

| Field | Bit Value | Duration |
|-------|-----------|----------|
| Start bit | Logic 0 | 1 clock cycle |
| Data bit 0 (LSB) | `P_DATA[0]` | 1 clock cycle |
| Data bit 1 | `P_DATA[1]` | 1 clock cycle |
| Data bit 2 | `P_DATA[2]` | 1 clock cycle |
| Data bit 3 | `P_DATA[3]` | 1 clock cycle |
| Data bit 4 | `P_DATA[4]` | 1 clock cycle |
| Data bit 5 | `P_DATA[5]` | 1 clock cycle |
| Data bit 6 | `P_DATA[6]` | 1 clock cycle |
| Data bit 7 (MSB) | `P_DATA[7]` | 1 clock cycle |
| Odd parity bit | Computed parity | 1 clock cycle |
| Stop bit | Logic 1 | 1 clock cycle |

**Total frame length: 11 clock cycles**

#### 6.1.3 Frame without Parity (`PAR_EN=0`)

| Field | Bit Value | Duration |
|-------|-----------|----------|
| Start bit | Logic 0 | 1 clock cycle |
| Data bit 0 (LSB) | `P_DATA[0]` | 1 clock cycle |
| Data bit 1 | `P_DATA[1]` | 1 clock cycle |
| Data bit 2 | `P_DATA[2]` | 1 clock cycle |
| Data bit 3 | `P_DATA[3]` | 1 clock cycle |
| Data bit 4 | `P_DATA[4]` | 1 clock cycle |
| Data bit 5 | `P_DATA[5]` | 1 clock cycle |
| Data bit 6 | `P_DATA[6]` | 1 clock cycle |
| Data bit 7 (MSB) | `P_DATA[7]` | 1 clock cycle |
| Stop bit | Logic 1 | 1 clock cycle |

**Total frame length: 10 clock cycles**

### 6.2 Parity Bit Computation

The parity bit shall be computed from the 8-bit data word as follows:

**Even Parity (`PAR_TYP = 0`):**

The parity bit shall be set to 1 when the number of logic-1 bits in `P_DATA` is odd, thereby making the total count of logic-1 bits (data + parity) even. The parity bit shall be 0 when the number of logic-1 bits in `P_DATA` is already even.

**Odd Parity (`PAR_TYP = 1`):**

The parity bit shall be set to 1 when the number of logic-1 bits in `P_DATA` is even, thereby making the total count of logic-1 bits (data + parity) odd. The parity bit shall be 0 when the number of logic-1 bits in `P_DATA` is already odd.

## 7. Reset Behavior

When `RST_n` is asserted (driven low), the module shall immediately:

- Enter the idle phase.
- Deassert `BUSY` to low.
- Drive `TX_OUT` to logic high (idle line condition).
- Return the transmitter to its initial idle condition.
