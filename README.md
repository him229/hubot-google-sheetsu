# hubot-google-sheetsu

[![NPM](https://nodei.co/npm/hubot-google-sheetsu.png?downloads=true&downloadRank=true&stars=true)](https://nodei.co/npm/hubot-google-sheetsu/)
[![NPM](https://nodei.co/npm-dl/hubot-google-sheetsu.png?height=3)](https://nodei.co/npm/hubot-google-sheetsu/)

A hubot script that allows you to connect to and consume a Google Spreadsheet.

See [`src/google-sheetsu.coffee`](src/google-sheetsu.coffee) for full documentation.

## Installation

In hubot project repo, run:

`npm install hubot-google-sheetsu --save`

Then add **hubot-google-sheetsu** to your `external-scripts.json`:

```json
[
  "hubot-google-sheetsu"
]
```

## Sample Interaction

```
user1>> hubot sheetsu cell B 5
hubot>> "Alan Turing"
```
## License

Copyright (c) 2016 Himank Yadav. Released under the MIT License. See
[LICENSE.md][license] for details.

[license]: LICENSE.md
