# README styling image

`images/default-styling.png` shows the default styling in the README. It is a screenshot of the rendered `example.qmd`. GitHub does not apply custom CSS in READMEs, so the image must match what the extension actually generates.

Check the image whenever you change any of these files:

- `_extensions/http-status/http-status.css`
- `_extensions/http-status/http-status.lua` (descriptions or classes)
- `example.qmd`

## Checking consistency

1. Render the example with `quarto render example.qmd`.
2. Open `example.html` in a browser and compare it with `images/default-styling.png`. Check that:
   - the sentences and status codes match, in the same order;
   - each status has the same description text;
   - each badge has the same background colour, text colour, weight, padding, and corner radius.
3. If anything differs, regenerate the image (below) and tell the user that you updated it. If the image already matches, leave it unchanged so the binary file does not churn.

Also check the README: the image's alt text lists the status codes shown, and the Styling section describes the badge colours. Update both if they no longer match.

## Regenerating the image

Serve the rendered page over HTTP, because the browser tools block `file:` URLs. For example, run `python3 -m http.server 8765` in the project root and open `http://localhost:8765/example.html`.

Capture the image the same way it was originally captured:

1. Remove the title block: `document.querySelector('#title-block-header').remove()`.
2. Style the `main` element with `padding: 16px 20px 4px`, `width: max-content`, and `background: #fff`.
3. Take an element screenshot of `main` and save it as `images/default-styling.png`.

Look at the new image before you finish, then stop the HTTP server and delete any temporary browser files, such as `.playwright-mcp/`.
