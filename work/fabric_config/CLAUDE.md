# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Build System & Common Commands

This is a Maven-based Java project with mixed Java/Python components and native C++ libraries.

### Maven Commands

```bash
# Build entire project
mvn clean install

# Build specific module
mvn clean install -pl ultx
mvn clean install -pl commandx
mvn clean install -pl accessx

# Run tests
mvn test
mvn test -pl commandx/commandx-frontend

# Run single test class
mvn test -Dtest=UserTest -pl commandx/commandx-frontend

# Format code (auto-formats on build)
mvn fmt:format

# Code quality checks
mvn checkstyle:check
mvn pmd:check
mvn spotbugs:check
```

### Native Components Build

```bash
# Build native libraries and package
make clean
make all

# Individual native components
make -C machineid all
make -C commandx/commandx-frontend/license-fxe
make -C commandx-agent/agent-wan/jni/fxe
```

### Python Components

```bash
# ULTXD daemon
cd ultxd/src
python setup.py build
python ultxd.py --help
```

## Architecture Overview

### Module Structure

The system follows a modular architecture with clear separation between modules:

- **ULTX**: Core platform providing user management, authentication, permissions, and shared infrastructure
- **CommandX**: System monitoring, metrics collection, and alerting infrastructure
- **CommandX-Agent**: Distributed monitoring agents (command, gpfs, lan, log, wan)
- **AccessX**: Data transfer, job management, and file synchronization system
- **Migration**: Database migration utilities for system upgrades

### Key Architectural Patterns

#### Module Registration System

Each major module uses `BaseApplicationRegistry` for initialization:

```java
// Located in ultx-common, extended by each module
// Registers modules like CommandXModule, AccessXModule, UsersModule
// Handles permission setup and database initialization
```

#### Three-Tier Architecture

Each module follows consistent layering:

- **Frontend**: Spring Boot controllers, REST endpoints, web configuration
- **Backend**: Service layer, DAO implementations, business logic
- **Common**: DTOs, utilities, shared interfaces, constants

#### Database Design

- Multiple databases: `vcinity-accessx`, `vcinity-accessx-statistic`, compliance databases
- JPA/Hibernate entities with standard DAO pattern
- Migration scripts in `distribution/db/` for schema evolution

#### Testing Framework

- TestNG for unit/integration tests (not JUnit)
- Spring Test integration with `@SpringockitoAnnotation` for mocks
- Extensive test coverage in commandx-frontend and commandx-agent modules

### Key Components

#### User Management (ULTX)

- Role-based permissions with fine-grained access control
- LDAP integration and local authentication
- License agreement tracking
- Multi-tenant user isolation

#### Agent Architecture (CommandX-Agent)

- Real-time and historical task implementations
- SNMP integration for device monitoring
- Mercury device support (FXE/FXV hardware)
- WebSocket communication for live updates

#### Job Processing (AccessX)

- Asynchronous job execution with progress tracking
- Multiple transfer protocols: RDMA, RFTP, Rsync, SyncX
- Directory watching with file system events
- Checksum verification and integrity checking

## Development Workflow

### Database Setup

Create required databases (as baymicro user):

```sql
CREATE DATABASE "vcinity-accessx" OWNER baymicro;
CREATE DATABASE "vcinity-accessx-statistic" OWNER baymicro;
```

### Code Formatting

The project uses Google code style with automatic formatting via `fmt-maven-plugin`. Code is auto-formatted on build.

### Native Development

- C++ components require specific hardware dependencies (FXE_HOME, FXV_HOME)
- JNI interfaces for Mercury device integration
- Machine ID generation for licensing

### Testing Strategy

- Unit tests focus on business logic and utility functions
- Integration tests use Spring context with mock DAOs
- Agent tests include extensive SNMP and device simulation
- Web controller tests use MockMVC framework

### Version Management

- Version defined in `ultxd/src/ultxd/version.py`
- Git commit integration in build process
- Build artifacts include version metadata and git hashes
