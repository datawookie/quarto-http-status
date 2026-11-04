# HTTP Status extension for Quarto

An inline shortcode that turns an HTTP status code into its code and registered description. For example, `{{< http-status 404 >}}` renders as **404 Not Found** inside a span with classes for all statuses, errors, and code 404.

## Installing

From a local checkout, run this in your Quarto project:

```sh
quarto add /path/to/quarto-http-status
```

This copies the extension into your project's `_extensions` directory. Commit that directory with your project if you use version control. You can also install it from GitHub with `quarto add datawookie/quarto-http-status`.

## Using

Put the shortcode wherever you want an inline status label:

```markdown
The request succeeded: {{< http-status 200 >}}.
The resource is missing: {{< http-status 404 >}}.
```

These render as “200 OK” and “404 Not Found”. The shortcode accepts exactly one three-digit code from the [IANA HTTP Status Code Registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml). An unknown or malformed code stops rendering with an error; it does not invent a description. The temporarily registered code 104 is included as “Upload Resumption Supported”. Unused and obsolete codes are omitted.

The output is a Pandoc span, so it works in HTML, PDF, Word, and other formats that support inline text. In HTML, it looks like this:

```html
<span class="http-status http-status-error http-status-404">404 Not Found</span>
```

Each span gets classes at these levels:

| Level | Class | Applies to |
| --- | --- | --- |
| All statuses | `http-status` | Every code |
| Category | `http-status-success` | 2xx codes |
| Category | `http-status-error` | 4xx and 5xx codes |
| Exact code | `http-status-<code>` | One code, such as `http-status-404` |

Informational (1xx) and redirection (3xx) codes have the all-status and exact-code classes, but no success or error class. For example, 200 gets `http-status http-status-success http-status-200`, while 404 gets `http-status http-status-error http-status-404`.

### Styling

Add a CSS rule to your project if you want a custom appearance:

```css
.http-status {
  font-weight: 600;
  white-space: nowrap;
}

.http-status-success { color: green; }
.http-status-error { color: darkred; }
.http-status-404 { text-decoration: underline; }
```

Then add the stylesheet to your document or project YAML with `format: { html: { css: styles.css } }`. The extension supplies the classes but does not impose a visual style.

## Example

Render [example.qmd](example.qmd) with `quarto render example.qmd`. It shows informational, success, redirection, client error, and server error codes in a short document.

## Status descriptions

The mapping follows the [IANA HTTP Status Code Registry](https://www.iana.org/assignments/http-status-codes/http-status-codes.xhtml), checked November 2026. To update it, edit [`_extensions/http-status/http-status.lua`](_extensions/http-status/http-status.lua) and compare the entries with IANA's current registry.
