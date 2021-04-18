# Uncompress

[![codecov](https://codecov.io/gh/didisouzacosta/uncompress/branch/main/graph/badge.svg?token=WWswGL8bsi)](https://codecov.io/gh/didisouzacosta/uncompress)
[![License](https://img.shields.io/cocoapods/l/Forms.svg?style=flat)](https://cocoapods.org/pods/Forms)

Simple library to decompress files .zip, .rar, .cbz, .cbr in React Native.

<table>
  <tr>
    <td><img src="./assets/preview_ios.gif" height="500" alt="Preview iOS" /></td>
    <td><img src="./assets/preview_android.gif" height="500" alt="Preview Android" /></td>
  </tr>
</table>

## Installation

```sh
yarn add uncompress

or

npm install uncompress
```

## Usage

```js
import Uncompress from 'uncompress';

// ...

await Uncompress.extract({
  filePath: 'temp/sample_comic.cbr',
  destination: 'data/comic',
});

// ...
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT
