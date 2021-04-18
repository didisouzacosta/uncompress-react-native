# Uncompress

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
