# Audio File Parser

## Installation:

Clone the repository:

```sh
git clone <repo>
cd <repo>
```

Install Ruby and dependencies:

```sh
asdf install # or rbenv install
bundle install
```

Run the tests:

```sh
bundle exec rspec
```

Run the script:

```sh
bundle exec ruby main.rb <input_dir>
```

Check the output in the `output` folder:

```sh
tree output
cat output/<timestamp>/<file>.xml
```

## Notes:

- I assumed that valid wav files with invalid extensions should be considered valid
- If there are multiple readers or writers, they can be extracted into `lib/readers` and `lib/writers` accordingly
- I assumed that `docker` and `docker compose` are not required for this exercise, and that `asdf` or `rbenv` are good enough
- Logging can and should be improved from using `puts` to a more structured approach

## Instructions:

- Write a ruby script that accepts a directory as an input. Eg. `ruby audio_parser.rb <input_dir>`
  - This script will extract metadata information from Wav files.
  - Any non Wav files will be ignored by the script.
  - The script should be able to generate applicable output(s) even if some files are ignored.

- Extract the following metadata information from the Wav files.
  - **IMPORTANT!** You must not use any existing third party **executable** to extract the data like mediainfo or ffprobe.
  - You are allowed to use any ruby library to help you read and interpret the bytes from the input files.

| Attribute       |     Type        |      Sample Value             | Mediainfo equivalend field name |
|-----------------|-----------------|-------------------------------|---------------------------------|
|Format           |String           |1 = "PCM",                     |Audio format                     |
|                 |                 |any other value = "Compressed" |                                 |
|Channel Count    |Integer          |2                              |Channel(s)                       |
|Sampling Rate    |Integer          |88200 or 88.2 kHz              |Sampling Rate                    |
|Byte Rate        |Integer          |150000                         |None                             |
|Bit Depth        |Integer          |32                             |Bit depth                        |
|Bit Rate         |Integer          |2822400                        |Bit rate                         |

Notes:
- Bit Rate is calculated using the formula: Sampling Rate * Channel Count * Bit Depth
- Format is either 1 or other integer number but for this exercise, we will map it to "PCM" if you detected 1 or "Compressed" for other integer values.

## Output
- Generate an output folder and the current timestamp to store your output files.
  - Eg. `output/1708976890/sample-file-3.xml`
- Write the output in an xml file using the provided wav.xsd file as your guide.
  - Each valid file should have a corresponding xml using the same file name. E.g. `sample-file-3.xml`
  - You are allowed to use any existing ruby xml libraries to make xml building faster.
- We will run your code over the given input_files and check the generated output xmls.

## Bonus Points
- Handling Errors
- Unit Test

## Hint
- You would have to do a quick research on the structure of a Wav file. (Easily found information)
- You can also check Resource Interchange File Format (RIFF).
- You don't need to parse the whole file. You just need to parse where the metadata info is stored.
- You can use mediainfo to validate your output manually.

Enjoy this Music Related Exercise :)
