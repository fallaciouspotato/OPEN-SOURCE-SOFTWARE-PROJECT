# OSS Audit — Linux Kernel

**Course:** Open Source Software (OSS NGMC)
**Student Name:** Priyanshu Chourasiya
**Roll Number:** 24BCG10013
**Chosen Software:** Linux Kernel
**License:** GNU General Public License v2 (GPL v2)

---

## About This Project

This repository contains five shell scripts written as part of the Open Source Audit capstone project. Each script demonstrates practical Linux command-line skills and relates to the audit of the Linux Kernel as an open-source project.

---

## Scripts Overview

### Script 1 — System Identity Report
**File:** `script1_system_identity.sh`
Prints a formatted welcome screen showing the Linux distribution name, kernel version, current user, home directory, system uptime, date and time, and the open-source license covering the OS.
**Concepts used:** Variables, echo, command substitution `$()`

---

### Script 2 — FOSS Package Inspector
**File:** `script2_package_inspector.sh`
Checks whether the Linux kernel package is installed on the system, displays its version and description, and prints a philosophy note about the software using a case statement. Works on both Debian/Ubuntu and RPM-based systems.
**Concepts used:** if-then-else, case statement, dpkg / rpm, grep, pipe

---

### Script 3 — Disk and Permission Auditor
**File:** `script3_disk_auditor.sh`
Loops through a list of important Linux system directories and reports the size, permissions, and owner of each. Includes a kernel-specific check for the kernel config file in `/boot`.
**Concepts used:** for loop, arrays, du, ls -ld, awk, cut, if -d check

---

### Script 4 — Log File Analyzer
**File:** `script4_log_analyzer.sh`
Reads a log file line by line and counts how many lines contain a given keyword. Prints a summary with the match count, percentage, and the last 5 matching lines.
**Concepts used:** while-read loop, if-then, counter variables, command-line arguments $1 $2, grep, tail

---

### Script 5 — Open Source Manifesto Generator
**File:** `script5_manifesto.sh`
Asks the user three interactive questions and composes a personalised open source philosophy statement, saving it to a .txt file named after the current user.
**Concepts used:** read for user input, string concatenation, writing to file with >>, date command, functions as aliases

---

## How to Run

### Requirements
- A Linux system (Ubuntu, Debian, Fedora, or similar)
- Bash shell (pre-installed on all Linux systems)
- For Script 2: either dpkg (Ubuntu/Debian) or rpm (Fedora/CentOS)
- For Script 4: a readable log file (e.g. /var/log/syslog)

### Setup — run this once
```bash
cd oss-audit-yourrollnumber
chmod +x *.sh
```

---

### Running each script

**Script 1 — System Identity Report**
```bash
./script1_system_identity.sh
```

**Script 2 — FOSS Package Inspector**
```bash
./script2_package_inspector.sh
```

**Script 3 — Disk and Permission Auditor**
```bash
./script3_disk_auditor.sh
```

**Script 4 — Log File Analyzer**
```bash
./script4_log_analyzer.sh /var/log/syslog kernel
```
Replace /var/log/syslog with any log file on your system.
Replace kernel with any keyword you want to search for.
On Fedora/CentOS use /var/log/messages instead.

**Script 5 — Open Source Manifesto Generator**
```bash
./script5_manifesto.sh
```

---

## Dependencies

| Script | Dependencies |
|--------|-------------|
| Script 1 | uname, whoami, uptime, date — all pre-installed |
| Script 2 | dpkg (Ubuntu) or rpm (Fedora/CentOS) — pre-installed |
| Script 3 | du, ls, awk, cut — all pre-installed |
| Script 4 | grep, tail — all pre-installed |
| Script 5 | date, whoami — all pre-installed |

No external packages need to be installed. All scripts run on a standard Linux installation.

---

## Repository Structure

```
oss-audit-yourrollnumber/
├── README.md
├── script1_system_identity.sh
├── script2_package_inspector.sh
├── script3_disk_auditor.sh
├── script4_log_analyzer.sh
└── script5_manifesto.sh
```

---

*Submitted as part of the OSS NGMC Capstone Project — VIT*
