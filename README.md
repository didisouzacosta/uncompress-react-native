# Uncompress

Simple library to decompress files .zip, .rar, .cbz, .cbr in React Native.

## Installation

```sh
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
