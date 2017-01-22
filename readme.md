# inline-console

An excellent inline console for browsers as React component based on jquery.terminal.

![npm downloads total](https://img.shields.io/npm/dt/inline-console.svg) ![npm version](https://img.shields.io/npm/v/inline-console.svg) ![npm license](https://img.shields.io/npm/l/inline-console.svg)

Very useful inline browser console which gives you full access to the JavaScript console and console output in case you do not have access to the developer console, e.g. when testing on [browserstack.com](http://browserstack.com) in certain mobile browsers. `inline-console` uses [jquery.terminal](http://terminal.jcubic.pl/) under the hood.

For a screenshot see the 'Advanced Example' below.

## Installation

Install the `inline-console` module via

```sh
npm install inline-console --save
```

or

```sh
yarn add inline-console
```

## Usage

The default export of `inline-console` is a simple React component. It offers a single property named `redirect` of type `Boolean` to control redirect behavior of `console.log` and its siblings. The component renders a `div` element with the CSS class `terminal` attached. This `div` element gets populated by `jquery.terminal`.

Example:

```js
import InlineConsole from 'inline-console';

const MyComponent = (props) => (
  <div className="inline-console">
    <InlineConsole redirect={true}/>
  </div>
);
```

You need to control the height of the terminal via CSS, to achieve typical terminal behavior. Example:

```css
.inline-console .terminal {
  height: 300px;
}
```

### Advanced Example

The following example illustrates a typical pattern I use in my applications.

* `index.html`

```html
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Example</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
</head>
<body>
  <div id="app"></div>
  <div id="inline-console"></div>
</body>
</html>
```

* `index.css`

```css
...
#inline-console {
  display: none;
}

#inline-console .terminal {
  height: 300px;
}
...
```

* `main.js`

```js
...
import InlineConsole from 'inline-console';
import queryString from 'query-string';

const query = queryString.parse(window.location.search);

if( typeof query['inline-console'] !== 'undefined'
 && JSON.parse(query['inline-console'])
) {
  const container = document.getElementById('inline-console');
  container.style.display = 'block';
  render(
    <InlineConsole redirect={true}/>,
    container
  );
}
...
```

![screenshot of example](readme-screenshot.png?raw=true)
