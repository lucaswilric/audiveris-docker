# audiveris-docker

## Set up a Docker container for [Audiveris](https://audiveris.kenai.com/) music scanning software

Dockerfile nicked from [Modulo7 by Khalian](https://github.com/Khalian/Modulo7).

This runs Audiveris in `-batch` mode, with any arguments you supply.

## Requirements

You'll need a working Docker server.

Everything from here downwards is currently aspirational. That is, I'd like it to work this way eventually, but it currently doesn't.

## Initialising

```bash
docker build -t audiveris .
```

## Usage

```bash
./audiveris.sh -input my_sheet_music.pdf -export my_music_xml_file.xml
```
