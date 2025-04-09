# JMeter Dockerized

A lightweight Docker setup to run [Apache JMeter](https://jmeter.apache.org/) load tests efficiently inside containers.

## Features

- Based on Alpine Linux with OpenJDK 8.
- Automatically configures JVM memory based on container resources.
- Easily parameterize test runs.
- Mounts local directories for test plans and results.
- Example test plan included.

## Getting Started

### Prerequisites

- Docker installed on your system.

### Build the Docker Image

Run the provided script:

```bash
./build.sh
```

This builds the Docker image tagged as `jmeter/docker:5.2.1`.

### Running Tests

Use the `run.sh` script to execute JMeter tests inside the container:

```bash
./run.sh -n -t your_test.jmx -l results.jtl -j jmeter.log -Jthreads=20 -Jrampup=20 -Jduration=240
```

- `-n`: Non-GUI mode.
- `-t`: Path to your JMeter test plan.
- `-l`: Results file.
- `-j`: Log file.
- `-J`: User-defined variables passed to the test plan.

The current directory is mounted inside the container, so all paths are relative to your host.

### Example Test Run

An example script `example.sh` is provided:

```bash
./example.sh
```

This will:

- Set test parameters (`THREADS`, `RAMPUP`, `DURATION`).
- Use the included test plan `test/JMeter_Docker_Script.jmx`.
- Save results to `test/JMeter_Docker_Script.jtl`.
- Save logs to `test/JMeter_Docker_Script.log`.

### Test Plan Details

The included test plan performs:

- A configurable number of threads (default 1, overridden via `-Jthreads`).
- Ramp-up and duration controlled via parameters.
- HTTP requests to `https://flooded.io/`.
- Cookie and cache management enabled.

## File Overview

| File/Dir                     | Purpose                                                      |
|------------------------------|--------------------------------------------------------------|
| `Dockerfile`                 | Builds Alpine-based JMeter image                             |
| `entrypoint.sh`              | Entrypoint script, configures JVM memory, runs JMeter        |
| `build.sh`                   | Builds the Docker image                                      |
| `run.sh`                     | Runs a JMeter container with mounted current directory       |
| `example.sh`                 | Example script to run the included test plan                 |
| `test/JMeter_Docker_Script.jmx` | Sample JMeter test plan targeting https://flooded.io/     |
| `test/JMeter_Docker_Script.jtl` | Sample output results file (generated after run)          |
| `test/JMeter_Docker_Script.log` | Sample JMeter log file (generated after run)              |

## License

MIT

## Maintainer

antonio@flood.io