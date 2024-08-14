# RCSB PDB CSV Generator | v1.2

Developed by Brian Yu, 2024, Shanghai.

This is a Windows-only Dart + Flutter software that enables users to query the [Protein Data Bank (RCSB PDB)](https://www.rcsb.org/) through its [search](https://search.rcsb.org/) and [data](https://data.rcsb.org/) APIs and download the entry response data as a CSV file. The parser encompasses all of the PDB's main data types (minus one duplicate) to allow users to customise their search queries.

## Software Information | v1.2
This software uses RCSB PDB's search API and its `full_text` query service. General search term(s), entry ID(s), or sequence are accepted, returning up to the first 10,000 results, sorted by score. Multiple search terms can be entered at once by separating terms with a comma.

More software information can be found under the "Settings" tab after installation.

## How to download

Two options are available:

#### 1. Installer

- Download the installer `csv_generator_setup.exe` from the root of this repository.
- Run the installer and follow setup instructions.

#### 2. Source Code
- Download/clone this repository and locally open the project in an editor/environment.
- Ensure that [Flutter is installed](https://docs.flutter.dev/get-started/install/windows/mobile).
- Navigate to the project root in your terminal.
- Run `flutter pub get`.
- Run `flutter build windows --release`. The resulting .exe should appear under `...\build\windows\x64\runner\Release` and should be runnable.

Feel free to contact if any issues occur.
